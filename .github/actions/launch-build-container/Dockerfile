FROM archlinux:base-devel

RUN useradd -M -r builder
RUN mkdir -p /pkgdest /build /srcdest
RUN chown builder /pkgdest /build /srcdest
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-builder
RUN echo -e "[repo]\nServer = file:///github/workspace/repo\nSigLevel = Optional TrustAll" >> /etc/pacman.conf
RUN ls -l /github/workspace 2>&1
RUN pacman-key --init
RUN pacman -Syu --noconfirm

COPY build.sh /build.sh

ENTRYPOINT [ "/usr/bin/bash", "/build.sh" ]
