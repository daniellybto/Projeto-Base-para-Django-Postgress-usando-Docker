#!/bin/ash

# O shell irá encerrar a execução do script quando um comando falhar
set -e

if [ "$DATABASE" = "postgres" ]
then
    echo "Aguardando o Banco de Dados PostgreSQL iniciar...."

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
      sleep 2
    done

    echo "Postgres iniciado!!!!"
fi

python manage.py flush --no-input
python manage.py migrate

exec "$@"