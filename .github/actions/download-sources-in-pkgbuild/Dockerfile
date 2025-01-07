FROM archlinux:base-devel

RUN useradd -M -r builder
RUN mkdir /pkgbuild
RUN chown builder /pkgbuild

COPY download.sh /download.sh
