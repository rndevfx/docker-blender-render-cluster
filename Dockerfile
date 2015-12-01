FROM d3v0x/gentoo
MAINTAINER d3v0x

RUN echo "MAKEOPTS=\"-j$(cat /proc/cpuinfo | grep processor | wc -l)\"" >> /etc/portage/make.conf
RUN emerge-webrsync -v

RUN echo -e "media-gfx/blender\n\
          =dev-cpp/eigen-3.2.6 ~amd64\n\
	  =sci-libs/ldl-2.1.0 ~amd64" >> /etc/portage/package.accept_keywords

RUN emerge app-portage/layman
RUN echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
RUN layman -f -o https://raw.github.com/hasufell/media-overlay/master/repository.xml -a media-overlay

RUN echo "media-gfx/blender cycles tiff python_single_target_python3_4" >> /etc/portage/package.use/blender
RUN emerge media-gfx/blender

ADD scripts /root/
ENV RENDER_MODE MASTER
CMD blender -b -P /root/renderServerStartup.py
EXPOSE 8000
