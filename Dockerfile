FROM ruby:2.4.5
RUN apt-get update -y && \
apt-get install -y autoconf \
bison \
build-essential \
ca-certificates \
curl \
dirmngr \
gawk \
git \
gnupg2 \
graphviz \
g++ \
libreadline6-dev \
libssl-dev \
libpq-dev \
libffi-dev \
libgmp-dev \
libyaml-dev \
libsqlite3-dev \
libgdbm-dev \
libncurses5-dev \
libtool \
make \
mariadb-client \
nano \
nodejs \
pkg-config \
ruby-dev \
zlib1g-dev

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
&& apt-get install -y nodejs
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.4.5"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt list --upgradable
RUN apt install yarn
RUN yarn add bootstrap-icons

RUN mkdir /app
WORKDIR /app
RUN mkdir /db
RUN mkdir /db/database
RUN chown -R $USER:$USER /db/database
ADD Gemfile /app
ADD Gemfile.lock /app/Gemfile.lock
RUN apt update && apt install -y  ruby-dev
RUN gem update --system
RUN gem install bundler
RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
RUN gem install mtik
RUN bundle install --no-deployment
RUN gem update --system 3.0.6
COPY . /app
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
