FROM archlinux:base-devel-20260308.0.497099 AS builder

ARG TZDB_VERSION
ARG TZDB_SOURCE
ARG MUSL_VERSION
ARG MUSL_SOURCE
ARG CA_SCRIPT=https://github.com/curl/curl/raw/refs/heads/master/scripts/mk-ca-bundle.pl

RUN pacman -Sy --needed --noconfirm python lzip >/dev/null

RUN mkdir -p \
 /base/{dev,etc,proc,run,sys,tmp,usr} \
 /base/usr/{bin,include,lib} \
 /base/usr/share/zoneinfo \
 /base/var/{cache,lib,lock,log,run,spool,tmp} \
 /base/etc/ssl/certs \
 && ln -s usr/bin /base/bin \
 && ln -s usr/bin /base/sbin \
 && ln -s usr/lib /base/lib \
 && ln -s usr/lib /base/lib64 \
 && ln -s lib /base/usr/lib64 \
 && ln -s bin /base/usr/sbin \
 && chmod a+rwx /base/tmp

RUN mkdir -p /build/timezone \
  && cd /build/timezone \
  && curl --silent --show-error --location --output tzdb.tar.lz ${TZDB_SOURCE} \
  && tar xf tzdb.tar.lz --strip-components=1 \
  && make -s ZFLAGS="-b slim" zones DESTDIR=/base \
  && ln -sf /usr/share/zoneinfo/UTC /base/etc/localtime

RUN mkdir -p /build/ca \
  && cd /build/ca \
  && curl --silent --show-error --location --output mk-ca-bundle.pl ${CA_SCRIPT} \
  && perl mk-ca-bundle.pl /base/etc/ssl/certs/ca-certificates.crt

RUN mkdir -p /build/musl \
  && cd /build/musl \
  && curl --silent --show-error --location --output musl.tar.gz ${MUSL_SOURCE} \
  && tar xf musl.tar.gz --strip-components=1 \
  && ./configure \
        --prefix=/usr \
        --syslibdir=/usr/lib \
        CFLAGS="-Os -fstack-protector-strong -D_FORTIFY_SOURCE=2 \
            -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables" \
        LDFLAGS="-Wl,-z,relro,-z,now -Wl,--as-needed" \
  && make -s -j$(nproc) \
  && make install DESTDIR=/base \
  && find /base/usr/lib -type f -name '*.so' ! -name 'ld-musl-*.so.1' -exec strip --strip-unneeded "{}" \;

# Cleanup base dir
RUN find /base/usr -type f -regex '.*\.\(h\|a\|o\)' -delete \
  && rm -fr /base/usr/include \
  && rm -fr /base/usr/share/{info,man,doc} \
  && rm -fr /base/var/cache \
  && rm -fr /base/var/db \
  && rm /base/usr/bin/musl-gcc \
  && rm /base/usr/lib/musl-gcc.specs

FROM scratch

ARG TZDB_VERSION
ARG MUSL_VERSION

COPY --from=builder /base /
COPY ./etc/ /base/etc/

LABEL org.opencontainers.image.title="distroless"
LABEL org.opencontainers.image.description="distroless base image with musl, tzdb, and mozilla ca certs"
LABEL org.opencontainers.image.source="https://github.com/simons-containers/distroless-musl"
LABEL org.opencontainers.image.version="${MUSL_VERSION}"
LABEL build.musl.version="${MUSL_VERSION}"
LABEL build.tzdb.version="${TZDB_VERSION}"
