# Linux

##  Verificar o IP da máquina
```
ip a | grep eth0
```

O comando ip a | grep eth0 é usado para exibir informações sobre a interface de rede eth0 no seu sistema. 

* `ip` a: Este comando exibe todas as interfaces de rede e suas respectivas informações, como endereços IP, estado da interface, etc.
* `|`: Este é o operador pipe, que redireciona a saída do comando anterior (ip a) como entrada para o próximo comando (grep).
* `grep eth0`: Este comando filtra a saída para mostrar apenas as linhas que contêm a palavra “eth0”, que é o nome da interface de rede.

Você também pode usar o seguinte comando:
```
ip addr show eth0
```
## Permissões
### Tipos de permissões
* Leitura ®: Permite visualizar o conteúdo de um arquivo ou listar o conteúdo de um diretório.
* Escrita (w): Permite modificar o conteúdo de um arquivo ou adicionar/remover arquivos em um diretório.
* Execução (x): Permite executar um arquivo (se for um programa ou script) ou acessar um diretório.

!!!tip "Dica"
      - 0: Nenhuma permissão (---)
      - 1: Permissão de execução (--x)
      - 2: Permissão de gravação (-w-)
      - 3: Permissão de gravação e execução (-wx)
      - 4: Permissão de leitura (r--)
      - 5: Permissão de leitura e execução (r-x)
      - 6: Permissão de leitura e gravação (rw-)
      - 7: Permissão total (leitura, gravação e execução) (rwx)

### Categorias de usuários
* Usuário (u): O proprietário do arquivo ou diretório.
* Grupo (g): Os usuários que pertencem ao mesmo grupo que o proprietário.
* Outros (o): Todos os outros usuários.
### Representação das permissões
As permissões são representadas por uma combinação de letras (r, w, x) ou por um valor numérico (octal). Por exemplo:

rwxr-xr-- significa que o proprietário tem todas as permissões, o grupo tem permissões de leitura e execução, e outros usuários têm apenas permissão de leitura.
755 no modo octal é equivalente a rwxr-xr-x.
### Comandos úteis
Visualizar Permissões: `ls -l` exibe uma lista detalhada dos arquivos e diretórios, incluindo suas permissões.
Alterar Permissões: chmod é usado para alterar as permissões. Por exemplo, `chmod 755` arquivo define as permissões para rwxr-xr-x.
### Exemplos
#### Adiciona permissão de execução para o proprietário do arquivo
```
chmod u+x script.sh
```
#### Remover a permissão de escrita para o grupo
```
chmod g-w arquivo.txt
```
#### Garantir acesso completo a um diretório
```
sudo chmod 777 diretorio/
```
O comando sudo chmod 777 diretorio/ é usado para alterar as permissões de um diretório no sistema. 

* `sudo`: Este comando é usado para executar o comando com privilégios de superusuário (root).
* `chmod`: Este comando altera as permissões de arquivos ou diretórios.
* `777`: Este é o conjunto de permissões que você está aplicando. 

!!!tip "Dica"
      * 7 (rwx): Permissões de leitura ®, escrita (w) e execução (x) para o proprietário
      * 7 (rwx): Permissões de leitura ®, escrita (w) e execução (x) para o grupo
      * 7 (rwx): Permissões de leitura ®, escrita (w) e execução (x) para outros usuários

#### Alterar o proprietário do diretório para o seu usuário atual
~~~
sudo chown -R $USER:$USER /caminho/do/diretorio
~~~

## Listar arquivos em um diretório
 `ls`: Listar arquivos e diretórios no diretório atual

## Chegar o diretório atual
`pwd`: Imprime o diretório de trabalho atual

## Navegar pelos diretórios
* `cd /`: Muda para o diretório raiz.
* `cd ~`: Muda para o diretório home do usuário.
* `cd /caminho/para/diretorio`: Muda para um diretório específico.
* `cd ..`: Muda para o diretório pai do diretório atual

## Criar um diretório
~~~
mkdir nome_do_diretorio
~~~

## Renomear diretórios e arquivos
### Renomear um diretório
~~~
mv diretorio_antigo diretorio_novo
~~~
### Renomear um arquivo
~~~
mv arquivo_antigo.txt arquivo_novo.txt
~~~
## Mover diretórios e arquivos
### Mover diretório
~~~
mv meu_diretorio novo_local/
~~~
### Mover um arquivo para um diretório específico
~~~
mv arquivo.txt /caminho/do/destino/
~~~
### Mover vários arquivos para um diretório
~~~
mv arquivo1.txt arquivo2.txt /caminho/do/destino/
~~~
### Usar curingas para mover arquivos com padrões específicos
~~~bash
mv *.txt /caminho/do/destino/
~~~

## Excluir diretórios
### Diretórios vazios
~~~
rmdir nome_do_diretorio
~~~
### Diretórios não vazios
~~~
rm -R nome_do_diretorio
~~~
## Criar um arquivo 
```
echo "hello world" > hello.txt
```

* `echo "hello world"`: Este comando imprime a frase “hello world” no terminal
* `>`: Este operador redireciona a saída do comando echo para um arquivo.
* `hello.txt`: Este é o nome do arquivo onde a frase será escrita. Se o arquivo não existir, ele será criado; se já existir, seu conteúdo será substituído pela nova frase.

## Abrir arquivo
`cat`: Imprimir o conteúdo de um arquivo

Exemplo:
~~~
cat /caminho/do/arquivo/hello.txt
~~~

## Editar arquivos
`nano`: Editar um arquivo usando o editor de texto Nano

Exemplo:
~~~
nano /caminho/do/arquivo/hello.txt
~~~

## Copiar arquivos
### Copiar um arquivo de uma pasta par outra
~~~
cp /home/usuario/arquivo.txt /home/usuario/backup/
~~~
### Encontrar e copiar vários arquivos de um diretório e subdiretórios para um diretório específico
~~~
find /home/usuario/imagens -type f -name "*.jpg" -exec cp {} /home/usuario/backup/ \;
~~~
## Deletar arquivos
~~~
del c:\simpsons\bart.doc - apaga o arquivo bart.doc presente na pasta simpsons;
~~~
## Criar chave SSH
```
ssh-keygen -t rsa -b 4096 -C "seu_email@example.com"
```
## Listar pacotes
O comando a seguir é usado para listar todos os pacotes Python instalados no seu ambiente que contêm a palavra “python” no nome.
~~~
pip3 freeze | grep python
~~~

* `pip3 freeze`: Este comando lista todos os pacotes instalados no seu ambiente Python, juntamente com suas versões.
* `|`: Este é o operador pipe, que redireciona a saída do comando anterior (pip3 freeze) como entrada para o próximo comando (grep).
* `grep python`: Este comando filtra a lista de pacotes para mostrar apenas aqueles que contêm a palavra “python” no nome.

## Ambiente virtual do Python
### Criar um ambiente virtual
Criar um ambiente virtual do python
~~~
python3 -m venv nome_do_ambiente
~~~

Criar um ambiente virtual do python a partir do diretório altual
~~~
python3 -m venv ./nome_do_amabiente
~~~
### Ativar o ambiente virtual
#### Linux/MacOS
   ```bash
   source nome_do_ambiente/bin/activate
   ```
#### Windows
   ```powershell
   nome_do_ambiente\Scripts\activate
   ```

## Verificar HASH
### Linux
~~~bash
sha256sum "nome_do_arquivo"
~~~
### Windows
~~~bash
certutil -hashfile "Caminho do arquivo" SHA256
~~~

