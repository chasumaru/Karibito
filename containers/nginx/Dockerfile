FROM nginx:1.21.1

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# Nginxの設定ファイルをコンテナにコピー(/etc/nginx/sites-enabled/ がデフォルトで認識されないため)
ADD nginx.conf /etc/nginx/conf.d/myapp.conf

# ビルド完了後にNginxをforegroundで起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf