#!/bin/sh

set -e # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Dglib=disabled \
    -Dgobject=disabled \
    -Dcairo=disabled \
    -Dchafa=disabled \
    -Dicu=disabled \
    -Dgraphite=disabled \
    -Dgraphite2=disabled \
    -Dfreetype=disabled \
    -Dgdi=disabled \
    -Ddirectwrite=disabled \
    -Dcoretext=enabled \
    -Dtests=disabled \
    -Dintrospection=disabled \
    -Ddocs=disabled \
    -Dbenchmark=disabled \
    -Dicu_builtin=false \
    -Dexperimental_api=false \
    -Dragel_subproject=false \
    -Dfuzzer_ldflags=
# The iOS SDK links sincosf but does not declare it.
sed -i '' '/HAVE_SINCOSF/d' build/config.h
meson compile -C build
meson install -C build
