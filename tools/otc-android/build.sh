#!/bin/bash
# Build do APK do OTClient (otc/) no WSL Ubuntu 24.04, seguindo otc/android/BUILDING.md,
# so para arm64-v8a e armeabi-v7a (celulares). Rodar como root no WSL:
#   wsl -d Ubuntu-24.04 -u root -- bash /mnt/d/crandoria/crystalserver/tools/otc-android/build.sh
# Saida: D:/crandoria/CrandoriaOT-OTC.apk. A chave fica em D:/crandoria/android-keystore
# (fora do git): sem ela, um APK novo nao instala por cima do anterior.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

SRC_WIN=/mnt/d/crandoria/crystalserver/otc
SRC=/srv/otc
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
NDK_VER=29.0.13599879
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/$NDK_VER
export VCPKG_ROOT=/opt/vcpkg-otc
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
KEYDIR=/mnt/d/crandoria/android-keystore
ABIS="arm64-v8a armeabi-v7a"
declare -A TRIPLET=( [arm64-v8a]=arm64-android [armeabi-v7a]=arm-neon-android )
declare -A CROSS=( [arm64-v8a]=aarch64-linux-android- [armeabi-v7a]=arm-linux-androideabi- )
declare -A CC=( [arm64-v8a]=aarch64-linux-android21- [armeabi-v7a]=armv7a-linux-androideabi21- )
declare -A HOSTCC=( [arm64-v8a]=gcc [armeabi-v7a]="gcc -m32" )

etapa() { echo "== $(date +%T) $*"; }

etapa "1/8 pacotes do sistema"
apt-get update -q >/dev/null
apt-get install -y -q --no-install-recommends openjdk-17-jdk-headless zip unzip curl git rsync python3 \
	gcc-multilib g++-multilib pkg-config autoconf automake libtool ninja-build cmake build-essential ca-certificates >/dev/null

etapa "2/8 Android SDK + NDK $NDK_VER"
if [ ! -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
	mkdir -p "$ANDROID_HOME/cmdline-tools"
	curl -sL https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -o /tmp/cmdtools.zip
	unzip -qo /tmp/cmdtools.zip -d /tmp/cmdtools
	rm -rf "$ANDROID_HOME/cmdline-tools/latest"; mv /tmp/cmdtools/cmdline-tools "$ANDROID_HOME/cmdline-tools/latest"
	rm -rf /tmp/cmdtools /tmp/cmdtools.zip
fi
yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" --licenses >/dev/null 2>&1 || true
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" \
	"ndk;$NDK_VER" "platforms;android-36" "build-tools;35.0.0" "cmake;3.22.1" "platform-tools" >/dev/null

etapa "3/8 vcpkg na baseline do otc"
BASE=$(grep '"builtin-baseline"' "$SRC_WIN/vcpkg.json" | grep -oE '[0-9a-f]{40}')
if [ ! -x "$VCPKG_ROOT/vcpkg" ]; then
	git clone -q https://github.com/microsoft/vcpkg.git "$VCPKG_ROOT"
	git -C "$VCPKG_ROOT" checkout -q "$BASE"
	"$VCPKG_ROOT/bootstrap-vcpkg.sh" -disableMetrics >/dev/null
fi

etapa "4/8 fonte para o disco do Linux"
mkdir -p "$SRC"
rsync -a --delete --exclude build/ --exclude '*.exe' --exclude '*.pdb' --exclude '*.log' \
	--exclude android/app/build/ --exclude android/.gradle/ --exclude android/app/.cxx/ \
	--exclude vcpkg_installed/ --exclude luajit-src/ --exclude android/app/libs/lib/ \
	--exclude android/app/src/main/assets/data.zip "$SRC_WIN/" "$SRC/"
find "$SRC" -name '*.sh' -exec sed -i 's/\r$//' {} +
sed -i 's/\r$//' "$SRC/android/gradlew"

etapa "5/8 LuaJIT para $ABIS"
if [ ! -d "$SRC/luajit-src/src" ]; then
	git clone -q https://github.com/LuaJIT/LuaJIT.git "$SRC/luajit-src"
	git -C "$SRC/luajit-src" checkout -q d0e88930ddde28ff662503f9f20facf34f7265aa
fi
NDKBIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin"
LIBS="$SRC/android/app/libs"
for ABI in $ABIS; do
	cd "$SRC/luajit-src"; make clean >/dev/null 2>&1 || true
	make -j"$(nproc)" amalg HOST_CC="${HOSTCC[$ABI]}" CROSS="$NDKBIN/${CROSS[$ABI]}" \
		STATIC_CC="$NDKBIN/${CC[$ABI]}clang" DYNAMIC_CC="$NDKBIN/${CC[$ABI]}clang -fPIC" \
		TARGET_LD="$NDKBIN/${CC[$ABI]}clang" TARGET_AR="$NDKBIN/llvm-ar rcus" TARGET_STRIP="$NDKBIN/llvm-strip" \
		TARGET_CFLAGS="-fPIC -DLUAJIT_UNWIND_EXTERNAL -fno-stack-protector" BUILDMODE=static >/dev/null
	mkdir -p "$LIBS/lib/$ABI" "$LIBS/include/luajit"
	cp src/libluajit.a "$LIBS/lib/$ABI/libluajit-5.1.a"
	cp src/lua.h src/lualib.h src/lauxlib.h src/luaconf.h src/luajit.h "$LIBS/include/luajit/"
	# luajit_rolling.h so existe em versoes mais novas que a fixada
	[ -f src/luajit_rolling.h ] && cp src/luajit_rolling.h "$LIBS/include/luajit/" || true
	echo "   luajit $ABI ok"
done
[ -f "$LIBS/include/luajit/lua.hpp" ] || printf 'extern "C" {\n#include "lua.h"\n#include "lualib.h"\n#include "lauxlib.h"\n}\n' > "$LIBS/include/luajit/lua.hpp"

etapa "6/8 dependencias vcpkg para $ABIS (a primeira vez demora)"
cd "$SRC"
for ABI in $ABIS; do
	"$VCPKG_ROOT/vcpkg" install --triplet "${TRIPLET[$ABI]}" --x-manifest-root=. --allow-unsupported > "/root/vcpkg-${TRIPLET[$ABI]}.log" 2>&1 \
		|| { tail -30 "/root/vcpkg-${TRIPLET[$ABI]}.log"; exit 1; }
	echo "   vcpkg ${TRIPLET[$ABI]} ok"
done

etapa "7/8 data.zip"
mkdir -p "$SRC/android/app/src/main/assets"
rm -f "$SRC/android/app/src/main/assets/data.zip"
cd "$SRC" && zip -qr android/app/src/main/assets/data.zip data mods modules init.lua otclientrc.lua config.ini cacert.pem
ls -lh "$SRC/android/app/src/main/assets/data.zip" | awk '{print "   data.zip", $5}'

etapa "8/8 chave de assinatura + gradle"
mkdir -p "$KEYDIR"
if [ ! -f "$KEYDIR/crandoria-otc.jks" ]; then
	SENHA=$(head -c 24 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 24)
	"$JAVA_HOME/bin/keytool" -genkeypair -keystore "$KEYDIR/crandoria-otc.jks" -alias crandoria-otc \
		-keyalg RSA -keysize 4096 -validity 36500 -storepass "$SENHA" -keypass "$SENHA" \
		-dname "CN=CrandoriaOT, O=CrandoriaOT, C=BR" >/dev/null 2>&1
	printf 'keystore=crandoria-otc.jks\nalias=crandoria-otc\nsenha=%s\n' "$SENHA" > "$KEYDIR/senha.txt"
	echo "   chave nova criada em $KEYDIR"
fi
export RELEASE_KEYSTORE="$KEYDIR/crandoria-otc.jks"
export RELEASE_KEY_ALIAS=crandoria-otc
export RELEASE_KEYSTORE_PASSWORD=$(grep '^senha=' "$KEYDIR/senha.txt" | cut -d= -f2)
export RELEASE_KEY_PASSWORD=$RELEASE_KEYSTORE_PASSWORD
cd "$SRC/android"; chmod +x gradlew
./gradlew --no-daemon assembleRelease -Potclient.android.abis=arm64-v8a,armeabi-v7a > /root/gradle.log 2>&1 \
	|| { grep -E "error:|FAILED|What went wrong" -A4 /root/gradle.log | head -40; tail -20 /root/gradle.log; exit 1; }

APK=$(ls "$SRC"/android/app/build/outputs/apk/release/*.apk | head -1)
cp "$APK" /mnt/d/crandoria/CrandoriaOT-OTC.apk
ls -lh /mnt/d/crandoria/CrandoriaOT-OTC.apk
etapa PRONTO
