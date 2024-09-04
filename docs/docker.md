# Comandos Docker

## Listar containers
```
docker container ls
```

!!! info
    Para verificar todos os containers (incluindo os que estão parados) pode-se utilizar o complemento -a após o ls com um espaço separando-os.

## Listar imagens
~~~
sudo docker image ls
~~~
!!! info
    Para verificar todos as imagens pode-se utilizar o complemento -a após o ls com um espaço separando-os.

## Criar uma imagem docker
~~~ python
sudo docker build -t nome_da_imagem .
~~~

## Logar no Docker HUB
```
sudo docker login
```

## Baixar uma imagem do Docker HUB
```
sudo docker pull alpine:edge
```

## Rodar um container no modo interativo
```
sudo docker run -it --name jupyter alpine:edge /bin/bash
```

## Acessar o container
```
sudo docker exec -it jupyter /bin/bash
```

## Rodar um container específico
```
sudo docker compose up -d jupyter
```

## Parar um container específico
```
sudo docker stop -d jupyter
```

## Copiar arquivos do host para o container
```
docker cp file.jar jupyter:/opt/spark/jars/
```

## Copiar arquivos do container para o host
```
docker cp jupyter:/opt/spark/jars/
```

## Clonar Imagem Docker

### Adicionar uma tag na imagem
```
docker tag alpine:edge your-repository/image
```

### Enviar imagem para o Docker Hub
```
docker push your-repository/image
```

### Desabilitar o Firewall
```
sudo ufw disable
```

# Modo Docker Swarm
## Init 
```
docker swarm init --advertise-addr <ip do host>
```

## Criar Stack
```
docker stack deploy -c docker-compose-swarm.yml big_data
```