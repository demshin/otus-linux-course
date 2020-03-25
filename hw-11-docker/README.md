# HW-11 Docker

## Task

Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx).

Определите разницу между контейнером и образом. Вывод опишите в домашнем задании.

Ответьте на вопрос: Можно ли в контейнере собрать ядро?

Собранный образ необходимо запушить в docker hub и дать ссылку на ваш репозиторий.

## Task with *

Создайте кастомные образы nginx и php, объедините их в docker-compose. После запуска nginx должен показывать php info.

Все собранные образы должны быть в docker hub.

## Results of HW

1. Create custom nginx image based on alpine.
   1. See `./nginx-alpine/Dockerfile`.
   2. To build run `docker build -t demshin/alpine-nginx`.
   3. To run `docker run --rm -p 80:80 -d --name nginx demshin/alpine-nginx`.
   4. To check `curl localhost` or open localhost in any browser.
2. Difference between docker image & docker container.
   1. Docker image is set of layers, that is used to execute code in a Docker container. An image is essentially built from the instructions for a complete and executable version of an application with dependencies, which relies on the host OS kernel.
   2. Docker container is an instance of a container. We can run multiple containers from the same image.
3. Build kernel in docker
   1. Yes, we can build kernel in docker.
   2. No, we can't run docker container with custom kernel.
4. See my custom image at [Docker Hub](https://hub.docker.com/repository/docker/demshin/alpine-nginx).

## Results of task with *

1. Run `docker-compose up -d`.
2. Get php info `curl localhost`.
