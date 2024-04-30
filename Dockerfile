FROM python:3.12.3-alpine3.18
LABEL Danielly Brito <danielly.eng@hotmail.com>

# impede que o python grave arquivos pyc no disco (equivalente ao comando: `python -B`)
ENV PYTHONDONTWRITEBYTECODE 1
# impede que o python armazene em buffer stdout e stderr (equivalente ao comando: `python -u`)
ENV PYTHONUNBUFFERED 1

# copiando o arquivo de script para dentro do container:
COPY ./entrypoint.sh /usr/src

# atualizando o PIP e adicionando um usuário sem privilégios de root para executar o conteiner:
RUN pip install --upgrade pip && \
    addgroup --gid 1001 --system userdjango && \
    adduser --no-create-home --disabled-password --uid 1001 --system -G "userdjango" userdjango && \
    # criando volume `data/`: -------------
    # mkdir /usr/src/data && \
    # chown userdjango:userdjango /usr/src/data && \
    # chmod 755 /usr/src/data && \
    sed -i 's/\r$//g' /usr/src/entrypoint.sh && \
    chmod +x /usr/src/entrypoint.sh && \
    chown userdjango:userdjango /usr/src/entrypoint.sh

# copia a pasta de desenvolvimento `app/djangoApp` para dentro do conteiner alterando o chown e permissão dessa pasta
COPY --chown=userdjango:userdjango ./app /usr/src/app

# definindo diretório de trabalho
WORKDIR /usr/src/app

# instala os pacotes necessários para a aplicação Django rodar e constrói a pasta `data/` que será um dos volumes utilizado pelo container
RUN pip install -r requirements.txt 

# definindo o usuário que irá 'iniciar' o docker:
USER userdjango
ENTRYPOINT ["/usr/src/entrypoint.sh"]