# Comandos MkDocs
## Instalar o MkDocs
### Dependências necessárias
```
sudo apt update
sudo apt upgrade
sudo apt install python3
sudo apt install python3-pip
```
### Instalando o MkDocs
~~~
pip install mkdocs
~~~
!!! tip "Dica"
    Recomenda-se criar um ambiente virtual do python para realizar a instalação do MkDocs

## Iniciar o servidor MkDocs
    mkdocs serve
## Adicionar imagem ao projeto
    ![Image](./imagem.png)

## Gerar arquivos estáticos
Quando estiver satisfeito com a documentação, você pode gerar os arquivos estáticos (HTML, CSS, JS) com o comando:
```
mkdocs build
```
Os arquivos gerados estarão na pasta site, prontos para serem hospedados em qualquer servidor web