FROM alpine:3.11.5
LABEL maintaner=demshin
RUN apk --no-cache --update add php7=7.3.16-r0 \
    php7-fpm=7.3.16-r0 \
    php7-opcache=7.3.16-r0
EXPOSE 9000
CMD ["php-fpm7", "-F"]
