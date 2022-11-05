#base image ベースイメージ:タグ
#FROM node:14.15.1-alpine
FROM node:16.13.1-alpine

ARG WORKDIR
ARG API_URL

#環境変数を定義
ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    #コンテナのNuxt.jsをブラウザから参照するためにip:0.0.0.0に紐付ける
    #https://ja.nuxtjs.org/faq/host-port/
    HOST=0.0.0.0 \
    API_URL=${API_URL}

#Dockerfile内で指定した命令を実行する
WORKDIR ${HOME}

# コンテナパッケージをインストール
COPY package*.json ./
RUN yarn install

# コンテナにNuxtプロジェクトをコピー
COPY . ./

#本番環境にアプリを構築
RUN yarn run build
# ここまで

#公開用ポート番号を指定
#http://localhost:3000
#EXPOSE ${CONTAINER_PORT}