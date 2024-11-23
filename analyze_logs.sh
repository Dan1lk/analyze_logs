#!/bin/bash

echo "Отчет сохранен в файл report.txt"

exec 1>report.txt

echo
echo "Отчет о логах веб-сервера"
echo "========================="
echo
echo "Общее количество запросов: $(awk 'END{ print NR }' access.log)"
echo
echo "Количество уникальных IP-адресов: $(awk '{ row_count[$1]++ } END { for (i in row_count) print i }' access.log | awk 'END{ print NR }')"
echo
echo "Количество запросов по методам: "
echo
awk -F'"' '{ print $2 }' access.log | awk '{ row_count[$1]++ } END { for (i in row_count) print row_count[i],  i }'
echo
echo "Самый популярный URL: $(awk '{ print $7 }' access.log | awk '{ row_count[$0]++ } END { for (i in row_count) print row_count[i],  i }' | sort | awk 'END { print $0 }')"
echo

