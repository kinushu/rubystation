FROM buildpack-deps:jessie
RUN apt-get update -qq && apt-get install -y \
       build-essential libpq-dev nodejs \
       locales locales-all \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

# ruby install

RUN echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc \
    && mkdir -v /usr/local/rbenv \
    && groupadd rbenv \
    && chgrp -R rbenv /usr/local/rbenv \
    && chmod -R g+rwxXs /usr/local/rbenv \
    && git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv \
    && git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH ${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}

RUN rbenv install 2.1.10
RUN rbenv global 2.1.10 && rbenv rehash
RUN gem update --system
RUN gem install bundler --force

RUN rbenv install 2.2.9
RUN rbenv global 2.2.9 && rbenv rehash
RUN gem update --system
RUN gem install bundler --force

RUN rbenv install 2.3.6
RUN rbenv global 2.3.6 && rbenv rehash
RUN gem update --system
RUN gem install bundler --force

RUN rbenv install 2.4.3
RUN rbenv global 2.4.3 && rbenv rehash
RUN gem update --system
RUN gem install bundler --force

CMD [ "irb" ]
