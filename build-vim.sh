#!/usr/bin/env bash

apk add --no-cache gcc make musl-dev ncurses-static git upx
git clone https://github.com/vim/vim /opt/vim
cd /opt/vim
LDFLAGS="-static" ./configure --with-tlib=ncursesw --with-features=tiny
make
make install
upx -q --lzma -o /out/vim-$(arch) /usr/local/bin/vim
chown $(stat -c '%u:%g' /out) /out/vim-$(arch)
