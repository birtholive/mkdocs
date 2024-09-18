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

## Subir uma imagem para o Docker Hub
```
docker push nome-do-usuario/nome-da-imagem

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

## Modo Docker Swarm
### Init 
```
docker swarm init --advertise-addr <ip do host>
```

### Criar Stack
```
docker stack deploy -c docker-compose-swarm.yml big_data
```

## Liberar acesso ao container no wsl para computadores remotos
Para acessar o container Docker rodando no Ubuntu dentro do WSL a partir de outra máquina Windows remota, você pode seguir os seguintes passos:

### Obter o endereço IP do WSL
No terminal do Ubuntu dentro do WSL, execute o comando:
```
ip addr show eth0
```

Anote o endereço IP exibido.
### Configurar o firewall do Windows
#### Abrir o “Windows Defender Firewall com Segurança Avançada”
* Pressione `Win + R` para abrir a janela “Executar”.
* Digite `wf.msc` e pressione Enter. Isso abrirá o “Windows Defender Firewall com Segurança Avançada”.
#### Criar uma nova regra de entrada
* No painel esquerdo, clique em “Regras de Entrada”.
* No painel direito, clique em “Nova Regra…”.
#### Selecionar o tipo de regra
* Na janela “Assistente para Nova Regra de Entrada”, selecione “Porta” e clique em “Avançar”.
#### Especificar as portas e protocolos
* Selecione “TCP”.
* Em “Portas locais específicas”, digite o numero da porta.
* Clique em “Avançar”.
#### Permitir a conexão
* Selecione “Permitir a conexão” e clique em “Avançar”.
#### Especificar o perfil
* Marque as opções “Domínio”, “Particular” e “Público” para garantir que a regra se aplique a todos os tipos de rede.
* Clique em “Avançar”.
#### Nomear a regra
* Dê um nome à regra, como “Permitir Porta NumeroPorta”.
* Clique em “Concluir”.
### Redirecionar a porta do WSL para o Windows
No terminal do Windows, execute o comando:
```
netsh interface portproxy add v4tov4 listenport=8005 listenaddress=0.0.0.0 connectport=8005 connectaddress=<IP_do_WSL>
```

Substitua <IP_do_WSL> pelo endereço IP obtido no passo 1.
### Acessar o container Docker da máquina remota
Na máquina Windows remota, abra um navegador ou use um cliente HTTP para acessar:
```
http://<IP_do_Windows>:8005
```

Substitua <IP_do_Windows> pelo endereço IP da máquina Windows onde o WSL está rodando.