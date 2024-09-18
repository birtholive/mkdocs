# Use a imagem base do Alpine Linux
FROM alpine:edge

# Instale as dependências necessárias
RUN apk add --no-cache python3 py3-pip

# Crie e ative um ambiente virtual a partir 
RUN python3 -m venv /venv
RUN /venv/bin/pip install --upgrade pip

# Instale o MkDocs no ambiente virtual
RUN /venv/bin/pip install --no-cache mkdocs mkdocs-material

# Defina o diretório de trabalho
WORKDIR /docs

# Copie os arquivos do projeto para o contêiner
COPY . .

# Exponha a porta que o MkDocs usará
EXPOSE 8000

# Comando para iniciar o MkDocs
CMD ["/venv/bin/mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
