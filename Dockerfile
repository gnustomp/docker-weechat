FROM ubuntu:xenial

RUN sed -i -e "s/archive/au.archive/g" /etc/apt/sources.list

RUN \
	apt-key	adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E && \
	bash -c "echo 'deb http://weechat.org/ubuntu xenial main' > /etc/apt/sources.list.d/weechat.list"

RUN \
	apt-get update && \
	apt-get install --no-install-recommends -y weechat-curses weechat-plugins tmux ncurses-term && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
RUN \
	sed -i -e "s/# en_AU.UTF-8/en_AU.UTF-8/" /etc/locale.gen && \
	locale-gen && \
	ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
	groupadd weechat && \
	useradd -m -g weechat weechat

USER weechat
WORKDIR /home/weechat
RUN \
	mkdir /home/weechat/.weechat && \
	echo 'set -g default-terminal "tmux-256color"' > ~/.tmux.conf && \
	echo 'set -g status off' >> ~/.tmux.conf
ENV LANG=en_AU.UTF-8
VOLUME ["/home/weechat/.weechat"]
CMD ["tmux", "-2u", "new-session", "weechat-curses"]
