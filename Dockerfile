FROM d3v0x/gentoo
MAINTAINER d3v0x

RUN emerge-webrsync -v

RUN emerge app-portage/layman
RUN echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
RUN layman -f -o https://raw.github.com/d3v0x/d3v0x-overlay/master/repository.xml -a d3v0x-overlay

RUN rm -f /etc/portage/package.accept_keywords; \
    mkdir /etc/portage/package.accept_keywords

ADD ./data/package.use/blender /etc/portage/package.use/blender
ADD ./data/package.accept_keywords/python /etc/portage/package.accept_keywords/python
ADD ./data/package.accept_keywords/blender /etc/portage/package.accept_keywords/blender
ADD ./data/profile/use.stable.mask /etc/portage/profile/use.stable.mask

RUN emerge -u dev-lang/python
RUN emerge media-gfx/blender
RUN rm -rf /usr/portage

ADD scripts /root/
CMD blender -b -P /root/renderServerStartup.py
EXPOSE 8000
