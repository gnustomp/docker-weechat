FROM ubuntu:xenial

RUN sed -i -e "s/archive/au.archive/g" /etc/apt/sources.list

RUN \
	apt-key	adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E && \
	bash -c "echo 'deb http://weechat.org/ubuntu xenial main' > /etc/apt/sources.list.d/weechat.list"

RUN \
	apt update && \
	apt install --no-install-recommends -y weechat-curses weechat-plugins && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
RUN \
	sed -i -e "s/# en_AU.UTF-8/en_AU.UTF-8/" /etc/locale.gen && \
	locale-gen && \
	ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
	groupadd weechat && \
	useradd -m -g weechat weechat

USER weechat
WORKDIR /home/weechat
RUN mkdir /home/weechat/.weechat
ENV \
	LC_ALL=en_AU.UTF-8 \
	LANG=en_AU.UTF-8 \
	TERM=xterm-256color
VOLUME ["/home/weechat/.weechat"]
CMD ["weechat-curses"]
