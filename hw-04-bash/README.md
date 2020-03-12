# HW-03 LVM

## Statement of the problem

Написать скрипт для cron, который раз в час присылает на заданную почту:
- X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
- Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
- все ошибки c момента последнего запуска
- список всех кодов возврата с указанием их кол-ва с момента последнего запуска
В письме должно быть прописан обрабатываемый временной диапазон, должна быть реализована защита от мультизапуска.
Критерии оценки: 5 - трапы и функции, а также sed и find +1 балл.

## HW Process

1. Function to find access.log path from argument (for example nginx, apache).
2. Function to get last hour from log.
3. Use trap to prevent multiple running.
4. Generate files for report.
5. Generate report.
6. Send report.
7. Need add `report.sh` to `/etc/cron.hourly`.
