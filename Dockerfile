FROM debian:stretch

RUN \
	apt-get update && \
	apt-get install -y gnupg apt-transport-https

RUN \
	apt-key	adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E && \
	bash -c "echo 'deb https://weechat.org/debian stretch main' > /etc/apt/sources.list.d/weechat.list"

RUN \
	apt-get update && \
	apt-get install -y locales weechat weechat-perl weechat-python weechat-scripts python-websocket && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
RUN \
	sed -i -e "s/# en_AU.UTF-8/en_AU.UTF-8/" /etc/locale.gen && \
	locale-gen && \
	ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
	useradd -m -u 1002 weechat

USER weechat
WORKDIR /home/weechat
RUN mkdir /home/weechat/.weechat
ENV \
	LC_ALL=en_AU.UTF-8 \
	LANG=en_AU.UTF-8 \
	TERM=xterm-256color
VOLUME ["/home/weechat/.weechat"]
CMD ["weechat-curses"]
