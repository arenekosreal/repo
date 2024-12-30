FROM archlinux:base-devel

RUN useradd -M -r builder
RUN mkdir -p /pkgdest /build /srcdest /startdir /var/lib/repo /mnt/pkgdest
RUN chown builder /pkgdest /build /srcdest
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-builder
RUN pacman-key --init

COPY build.sh /build.sh
WORKDIR /startdir
ENTRYPOINT [ "/usr/bin/bash", "/build.sh" ]
