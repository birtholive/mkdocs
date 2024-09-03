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
## Acessar um container
```
docker exec –it <container id> /bin/bash
```
ou somente usando o sh no final
```
docker exec –it <container id> /bin/sh
```
## Parar um container
~~~
docker stop <container id>
~~~

## Verificar informações sobre uma instalação
~~~
pip3 freeze | grep python
~~~

## Criar uma imagem docker
~~~ python
sudo docker build -t nome_da_imagem .
~~~

## Login to Docker HUB
```
sudo docker login
```

## Pull the image from Docker HUB
```
sudo docker pull wlcamargo/jupyter
```

## Run the container in interactive mode
```
sudo docker run -it --name jupyter wlcamargo/jupyter /bin/bash
```

## Access the container
```
sudo docker exec -it jupyter /bin/bash
```

## Run a specific container
```
sudo docker compose up -d jupyter
```

## Stop a specific container
```
sudo docker stop -d jupyter
```

## Copy file from host to container
```
docker cp file.jar jupyter:/opt/spark/jars/
```

## Copy file from container to host
```
docker cp jupyter:/opt/spark/jars/
```

## Clone Docker Image

### Tag the image
```
docker tag wlcamargo/spark-master your-repository/image
```

### Push the image
```
docker push your-repository/image
```

### Disable Firewall
```
sudo ufw disable
```

# Docker Swarm Mode
## Init 
```
docker swarm init --advertise-addr <ip do host>
```

## Create Stack
```
docker stack deploy -c docker-compose-swarm.yml big_data
```