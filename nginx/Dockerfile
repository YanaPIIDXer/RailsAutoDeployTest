# 参考：https://qiita.com/eighty8/items/0288ab9c127ddb683315

FROM nginx:1.15.8

RUN rm -f /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/conf.d/webapp.conf

EXPOSE 80
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
