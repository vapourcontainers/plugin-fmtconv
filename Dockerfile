# syntax=docker/dockerfile:1.4

FROM ghcr.io/vapourcontainers/plugin-build-base:latest AS builder

RUN <<EOF
git clone https://github.com/EleonoreMizo/fmtconv.git -b r30 --depth 1 /tmp/fmtconv
cd /tmp/fmtconv/build/unix
./autogen.sh
./configure ${STD_CONFIGURE_ARGS}
make -j$(nproc)
mv .libs/libfmtconv.so /usr/local/lib/vapoursynth/
EOF

FROM scratch

COPY --from=builder /usr/local/lib/vapoursynth/libfmtconv.so /usr/local/lib/vapoursynth/
