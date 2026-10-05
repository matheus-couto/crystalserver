'use strict';

/**
 * Gold, level e skill para personagem OFFLINE, direto no banco.
 *
 * Offline o personagem nao esta na memoria do servidor, entao o banco e a
 * verdade e ele encontra tudo no proximo login - sem depender de script no
 * jogo nem de reiniciar o servidor. Online e o contrario: o servidor salva a
 * copia da memoria por cima no logout, entao para online o painel enfileira o
 * comando e o globalevent_panel_commands.lua aplica pela API do jogo.
 *
 * Level mexe em mais que level e experiencia: vida, mana e capacidade maximas
 * ficam gravadas prontas no banco, e o servidor nao as recalcula no login.
 * Aqui elas sobem pelos ganhos da vocacao, como no Player::addExperience.
 */

const fs = require('fs/promises');
const path = require('path');

const RAIZ = process.env.SERVER_ROOT || '/srv/crystalserver';
// coreDirectory = "data" no config.lua; e de la que o servidor le vocations.xml.
const VOCACOES = path.join(RAIZ, 'data', 'XML', 'vocations.xml');

const LIMITES = { gold: 100000000, level: 1000, skill: 200 };

// Colunas de cada skill: nivel e o progresso dentro do nivel.
const SKILLS = {
  fist: ['skill_fist', 'skill_fist_tries', 'Fist'],
  club: ['skill_club', 'skill_club_tries', 'Club'],
  sword: ['skill_sword', 'skill_sword_tries', 'Sword'],
  axe: ['skill_axe', 'skill_axe_tries', 'Axe'],
  distance: ['skill_dist', 'skill_dist_tries', 'Distance'],
  shielding: ['skill_shielding', 'skill_shielding_tries', 'Shielding'],
  fishing: ['skill_fishing', 'skill_fishing_tries', 'Fishing'],
  magic: ['maglevel', 'manaspent', 'Magic level'],
};

/** Experiencia do inicio de um level: o Player::getExpForLevel do servidor. */
function expDoLevel(level) {
  const l = BigInt(level);
  return (((l - 6n) * l + 17n) * l - 12n) / 6n * 100n;
}

let cacheVoc = { mtime: 0, mapa: null };

/** id da vocacao -> ganhos por level, lido do vocations.xml do servidor. */
async function ganhosDaVocacao(id) {
  const st = await fs.stat(VOCACOES);
  if (!cacheVoc.mapa || cacheVoc.mtime !== st.mtimeMs) {
    const xml = await fs.readFile(VOCACOES, 'utf8');
    const mapa = new Map();
    for (const m of xml.matchAll(/<vocation\b([^>]*)>/g)) {
      const attr = (nome) => {
        const a = new RegExp(`\\b${nome}="(\\d+)"`).exec(m[1]);
        return a ? Number(a[1]) : 0;
      };
      mapa.set(attr('id'), { hp: attr('gainhp'), mana: attr('gainmana'), cap: attr('gaincap') });
    }
    cacheVoc = { mtime: st.mtimeMs, mapa };
  }
  const g = cacheVoc.mapa.get(Number(id));
  if (!g) throw new Error(`vocacao ${id} nao encontrada no vocations.xml`);
  return g;
}

/**
 * Aplica no banco e devolve um resumo, ou { online: true } se o personagem
 * estiver online (quem chama enfileira o comando para o jogo).
 *
 * A checagem de online e a escrita ficam na mesma transacao, com a linha do
 * personagem travada: se ele logar no meio, o login le o valor ja gravado.
 */
async function aplicarOffline(db, playerId, tipo, skill, qtd) {
  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();
    const [[p]] = await conn.query(
      'SELECT `id`,`name`,`level`,`experience`,`vocation`,`balance`,`healthmax`,`manamax`,`cap`,'
      + '`maglevel`,`skill_fist`,`skill_club`,`skill_sword`,`skill_axe`,`skill_dist`,`skill_shielding`,`skill_fishing` '
      + 'FROM `players` WHERE `id` = ? FOR UPDATE', [playerId]);
    if (!p) throw new Error('personagem nao existe');
    const [[on]] = await conn.query('SELECT COUNT(*) AS `n` FROM `players_online` WHERE `player_id` = ?', [playerId]);
    if (Number(on.n) > 0) {
      await conn.rollback();
      return { online: true };
    }

    let resumo;
    if (tipo === 'gold') {
      await conn.query('UPDATE `players` SET `balance` = `balance` + ? WHERE `id` = ?', [qtd, playerId]);
      resumo = `banco de ${p.name}: ${Number(p.balance).toLocaleString('pt-BR')} -> ${(Number(p.balance) + qtd).toLocaleString('pt-BR')} gold`;
    } else if (tipo === 'level') {
      const g = await ganhosDaVocacao(p.vocation);
      const novo = Number(p.level) + qtd;
      const hp = Number(p.healthmax) + g.hp * qtd;
      const mana = Number(p.manamax) + g.mana * qtd;
      await conn.query(
        'UPDATE `players` SET `level` = ?, `experience` = ?, `healthmax` = ?, `health` = ?, '
        + '`manamax` = ?, `mana` = ?, `cap` = `cap` + ? WHERE `id` = ?',
        [novo, expDoLevel(novo).toString(), hp, hp, mana, mana, g.cap * qtd, playerId]);
      resumo = `${p.name}: level ${p.level} -> ${novo} (vida ${hp}, mana ${mana})`;
    } else if (tipo === 'skill') {
      const s = SKILLS[skill];
      if (!s) throw new Error('skill invalida');
      const [col, progresso, rotulo] = s;
      await conn.query(`UPDATE \`players\` SET \`${col}\` = \`${col}\` + ?, \`${progresso}\` = 0 WHERE \`id\` = ?`, [qtd, playerId]);
      resumo = `${p.name}: ${rotulo} ${p[col]} -> ${Number(p[col]) + qtd}`;
    } else {
      throw new Error('tipo invalido');
    }

    await conn.commit();
    return { ok: true, resumo };
  } catch (err) {
    await conn.rollback().catch(() => {});
    throw err;
  } finally {
    conn.release();
  }
}

module.exports = { aplicarOffline, expDoLevel, LIMITES, SKILLS };
