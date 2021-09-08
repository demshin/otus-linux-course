FROM alpine:3.11.5
LABEL maintaner=demshin
RUN apk --no-cache --update add nginx=1.16.1-r6 && mkdir -p /run/nginx
RUN adduser -D -g 'www' www
WORKDIR /www
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./www/index.html .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
