FROM ruby:3.1
ENV BUNDLER_VERSION=2.3.10

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN apt-get install -y vim

# ルート直下に${APP_NAME}という名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /myapp
WORKDIR /myapp
# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# bundler(v=2.3.7)ではエラーが発生したため変更
RUN gem install bundler -v ${BUNDLER_VERSION} && \
    bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /myapp

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets