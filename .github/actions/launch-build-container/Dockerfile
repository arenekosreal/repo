FROM archlinux:base-devel

ARG CUSTOM_REPO=repo

RUN useradd -M -r builder
RUN mkdir -p /pkgdest /build /srcdest /startdir /var/lib/repo /mnt/pkgdest
RUN chown builder /pkgdest /build /srcdest
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-builder
RUN echo -e "[${CUSTOM_REPO}]\nServer = file:///var/lib/repo\nSigLevel = Optional TrustAll" >> /etc/pacman.conf
RUN pacman-key --init

COPY build.sh /build.sh

ENTRYPOINT [ "/usr/bin/bash", "/build.sh" ]
