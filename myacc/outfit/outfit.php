<?php
/**
 * Gerador de imagem de outfit.
 *
 * O MyAAC monta a URL como
 *     outfit.php?id=1824&addons=0&head=95&body=113&legs=39&feet=115
 * e espera uma imagem de volta.
 *
 * As camadas cruas (base e mascara) sao extraidas dos assets do cliente por
 * tools/item-images/outfits.py e ficam em data/. Aqui so acontece a
 * coloracao, porque a cor depende do personagem: sao 133 tons em quatro
 * partes do corpo, combinacoes demais para pre-renderizar.
 *
 * O resultado vai para cache/, entao cada combinacao e desenhada uma vez.
 */

const OUTFIT_SIZE = 64;
const HSI_H_STEPS = 19;
const HSI_SI_VALUES = 7;

$dataDir  = __DIR__ . '/data';
$cacheDir = __DIR__ . '/cache';

$id     = isset($_GET['id']) ? (int) $_GET['id'] : 0;
$addons = isset($_GET['addons']) ? (int) $_GET['addons'] : 0;
$head   = isset($_GET['head']) ? (int) $_GET['head'] : 0;
$body   = isset($_GET['body']) ? (int) $_GET['body'] : 0;
$legs   = isset($_GET['legs']) ? (int) $_GET['legs'] : 0;
$feet   = isset($_GET['feet']) ? (int) $_GET['feet'] : 0;

if ($id <= 0 || $id > 65535) {
	notFound();
}

$addons = max(0, min(3, $addons));
foreach ([$head, $body, $legs, $feet] as $c) {
	if ($c < 0 || $c >= HSI_H_STEPS * HSI_SI_VALUES) {
		notFound();
	}
}

$cacheFile = sprintf('%s/%d_%d_%d_%d_%d_%d.png',
	$cacheDir, $id, $addons, $head, $body, $legs, $feet);

if (is_file($cacheFile)) {
	output($cacheFile);
}

// Camada 0 e sempre o corpo. Os addons entram por cima, quando o bit
// correspondente estiver ligado: 1 = primeiro addon, 2 = segundo.
$canvas = imagecreatetruecolor(OUTFIT_SIZE, OUTFIT_SIZE);
imagealphablending($canvas, false);
imagesavealpha($canvas, true);
imagefill($canvas, 0, 0, imagecolorallocatealpha($canvas, 0, 0, 0, 127));
imagealphablending($canvas, true);

$drew = false;
$levels = [0];
if ($addons & 1) { $levels[] = 1; }
if ($addons & 2) { $levels[] = 2; }

foreach ($levels as $level) {
	$basePath = sprintf('%s/%d_%d_base.png', $dataDir, $id, $level);
	if (!is_file($basePath)) {
		continue;
	}
	$layer = imagecreatefrompng($basePath);
	if (!$layer) {
		continue;
	}

	$maskPath = sprintf('%s/%d_%d_mask.png', $dataDir, $id, $level);
	if (is_file($maskPath)) {
		$mask = imagecreatefrompng($maskPath);
		if ($mask) {
			tint($layer, $mask, $head, $body, $legs, $feet);
			imagedestroy($mask);
		}
	}

	imagecopy($canvas, $layer, 0, 0, 0, 0, OUTFIT_SIZE, OUTFIT_SIZE);
	imagedestroy($layer);
	$drew = true;
}

if (!$drew) {
	imagedestroy($canvas);
	notFound();
}

if (!is_dir($cacheDir)) {
	@mkdir($cacheDir, 0775, true);
}
@imagepng($canvas, $cacheFile);

header('Content-Type: image/png');
header('Cache-Control: public, max-age=604800');
imagepng($canvas);
imagedestroy($canvas);
exit;


/**
 * Onde a mascara tem um dos quatro marcadores puros, multiplica o pixel do
 * corpo pela cor escolhida. E o mesmo que o cliente faz ao desenhar.
 */
function tint($layer, $mask, $head, $body, $legs, $feet): void
{
	$table = [
		0xFFFF00 => paletteColor($head),  // amarelo -> cabeca
		0xFF0000 => paletteColor($body),  // vermelho -> corpo
		0x00FF00 => paletteColor($legs),  // verde -> pernas
		0x0000FF => paletteColor($feet),  // azul -> pes
	];

	for ($y = 0; $y < OUTFIT_SIZE; $y++) {
		for ($x = 0; $x < OUTFIT_SIZE; $x++) {
			$bp = imagecolorat($layer, $x, $y);
			if ((($bp >> 24) & 0x7F) === 127) {
				continue; // transparente
			}
			$mp = imagecolorat($mask, $x, $y);
			if ((($mp >> 24) & 0x7F) === 127) {
				continue;
			}

			$key = $mp & 0xFFFFFF;
			if (!isset($table[$key])) {
				continue;
			}
			[$tr, $tg, $tb] = $table[$key];

			$alpha = ($bp >> 24) & 0x7F;
			$r = intdiv((($bp >> 16) & 0xFF) * $tr, 255);
			$g = intdiv((($bp >> 8) & 0xFF) * $tg, 255);
			$b = intdiv(($bp & 0xFF) * $tb, 255);

			imagesetpixel($layer, $x, $y,
				imagecolorallocatealpha($layer, $r, $g, $b, $alpha));
		}
	}
}

/** Paleta de 133 cores do Tibia, o mesmo calculo do cliente. */
function paletteColor(int $index): array
{
	if ($index >= HSI_H_STEPS * HSI_SI_VALUES) {
		$index = 0;
	}

	if ($index % HSI_H_STEPS !== 0) {
		$loc1 = ($index % HSI_H_STEPS) / 18.0;
		$loc2 = 1.0;
		$loc3 = 1.0;
		switch (intdiv($index, HSI_H_STEPS)) {
			case 0: $loc2 = 0.25;  $loc3 = 1.00; break;
			case 1: $loc2 = 0.25;  $loc3 = 0.75; break;
			case 2: $loc2 = 0.50;  $loc3 = 0.75; break;
			case 3: $loc2 = 0.667; $loc3 = 0.75; break;
			case 4: $loc2 = 1.00;  $loc3 = 1.00; break;
			case 5: $loc2 = 1.00;  $loc3 = 0.75; break;
			case 6: $loc2 = 1.00;  $loc3 = 0.50; break;
		}
	} else {
		$loc1 = 0.0;
		$loc2 = 0.0;
		$loc3 = 1.0 - $index / HSI_H_STEPS / HSI_SI_VALUES;
	}

	if ($loc3 == 0.0) {
		return [0, 0, 0];
	}
	if ($loc2 == 0.0) {
		$v = (int) ($loc3 * 255);
		return [$v, $v, $v];
	}

	if ($loc1 < 1 / 6) {
		$r = $loc3; $g = $loc3 * (1 - $loc2 * (1 - ($loc1 * 6))); $b = $loc3 * (1 - $loc2);
	} elseif ($loc1 < 2 / 6) {
		$r = $loc3 * (1 - $loc2 * (($loc1 - 1 / 6) * 6)); $g = $loc3; $b = $loc3 * (1 - $loc2);
	} elseif ($loc1 < 3 / 6) {
		$r = $loc3 * (1 - $loc2); $g = $loc3; $b = $loc3 * (1 - $loc2 * (1 - (($loc1 - 2 / 6) * 6)));
	} elseif ($loc1 < 4 / 6) {
		$r = $loc3 * (1 - $loc2); $g = $loc3 * (1 - $loc2 * (($loc1 - 3 / 6) * 6)); $b = $loc3;
	} elseif ($loc1 < 5 / 6) {
		$r = $loc3 * (1 - $loc2 * (1 - (($loc1 - 4 / 6) * 6))); $g = $loc3 * (1 - $loc2); $b = $loc3;
	} else {
		$r = $loc3; $g = $loc3 * (1 - $loc2); $b = $loc3 * (1 - $loc2 * (($loc1 - 5 / 6) * 6));
	}

	return [(int) ($r * 255), (int) ($g * 255), (int) ($b * 255)];
}

function output(string $file): void
{
	header('Content-Type: image/png');
	header('Cache-Control: public, max-age=604800');
	readfile($file);
	exit;
}

function notFound(): void
{
	// Um PNG 1x1 transparente em vez de 404: o template nao trata erro e
	// mostraria o icone de imagem quebrada.
	header('Content-Type: image/png');
	header('Cache-Control: public, max-age=3600');
	echo base64_decode(
		'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk'
		. 'YPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=='
	);
	exit;
}
