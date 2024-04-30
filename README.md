# Ambiente de desenvolvimento em Django com Docker

Esse se trata de um ambiente básico e prático para desenvolvimentode aplicações Django com Banco de Dados Postgres.

Caso você queira utilizar esse ambiente para iniciar seus projetos em Django + Postgres vá em frente e siga as orientações abaixo ^^


## Pré-Requisitos

Tenha certeza de que você tenha o [Docker](https://docs.docker.com/get-docker/) instalado em seu computador.

A primeira coisa a se fazer é criar nosso arquivo de configuração `.env` para isso crie uma cópia do arquivo `.env-example` e nomei-o para: `.env` dentro da pasta 'conf/'.

Ao aacessar seu novo arquivo de configuração, `.env`, perceba que existem alguns parâmetros que tem um comentário ("#MUDAR AQUI") que são exatamente os parâmetros onde você precisará adicionar algumas informações que **precisam** ser definidas para que o ambiente seja criado corretamente!
Os Parâmetros que você precisará definir são:
- SECRET_KEY
  - esse parâmetro é uma "chave" que é usada em seu sistema Django. Você pode literalmente colocar qualquer coisa, caso esteja sem imaginação copie e cole o seguinte código: `dani-django-sorrindo-a-toa`
- POSTGRES_DB
  - define o nome do banco de dados
- POSTGRES_USER
  - define o nome do usuário do banco de dados
- POSTGRES_PASSWORD
  - define a senha do usuário no banco de dados

Após isso acesse, via terminal/cmd, esse repositório. Tenha certeza de que você esteja no mesmo diretório do `docker-compose.yml` para que você inicie então a instalação!


## Instalação

Rode então o comando para construir a imagem do container e subir o container:

```bash
  docker compose up -d --build
```
    
Para confirmar que está tudo funcionando rode:
```bash
  docker container ls
```
> *O comando de build acima só precisará ser feito uma única vez, pois uma vez que você subir essa imagem e não alterá-la você não precisará mais construí-la*


## Usando o ambiente em produção

#### Executando Comandos:

Com os containers em execução você pode executar os comandos do django (python manage.py ...) de duas formas:

```bash
  # acessando diretamente o container 'por dentro' tendo acesso ao bash/ash/sh do container
  docker exec -it [NOME_DO_CONTAINER] ash

  docker exec -it djangoWeb ash
```
*para sair - NESSE AMBIENTE EM ESPECÍFICO - você pode digitar `exit` que ele não matará o container, já que o comando que está mantendo o container 'vivo' não é o terminal*


Outra forma de executar comandos no container é fazendo isso sem 'entrar' dentro do container:

```bash
  docker exec -it [NOME_DO_CONTAINER] [COMANDO]

  docker exec -it djangoWeb ls -lha

  # ou até rodando as migrations por exemplo:
  docker exec -it djangoWeb python manage.py migrate --noinput
```

---
####  Rodando as migrations:


```bash
  docker exec -it djangoWeb python manage.py migrate --noinput
```

---
####  Parar todos os Containers em execução:


```bash
  docker container stop [NOME_DO_CONTAINER]

  # nesse caso, caso eu queira pausar os dois containers de uma vez:
  docker container stop djangoWeb postgressDB

  # ou outra opção:
  docker compose stop
```


---
####  Startar/Re-startar todos os Containers do projeto 'stopados'/parados:


```bash
  docker compose up -d
```


---
####  Re-buildar a imagem de forçadamente


```bash
  docker compose up -d --build --force-recreate
```

