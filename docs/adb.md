# Remover apps do android
## Pré-requisitos
Esta dica não precisa de root, mas precisamos habilitar a Depuração USB. Para tal faça:

1. Abra o aplicativo Ajustes
2. No final da lista toque em Sobre o telefone
3. Toque no item Informações sobre o software
4. No item Número de montagem, toque umas 7 vezes seguidas
5. Retorne à tela inicial do app Ajustes
6. Toque em Opções de desenvolvedor
7. Aceite o Aviso Legal
8. Maque a opção Depuração USB

## Instalar adb
~~~bash
sudo apt-get install android-tools-adb
~~~

## Listando apps com o ADB
~~~bash
adb shell pm list packages
~~~
Filtre a saída com o grep se desejar.
~~~bash
adb shell pm list packages | grep weather
~~~
## Remover pacotes
~~~bash
adb shell pm uninstall --user 0 nome_do_pacote
~~~
## Listando apps desativados com o ADB
~~~bash
adb shell pm list packages -d
~~~

## Alguns pacotes que podem ser removidos
- Chrome ( com.android.chrome )
- YouTube ( com.google.android.youtube )
- Hangouts ( com.google.android.talk )
- Drive ( com.google.android.apps.docs )
- Plus ( com.google.android.apps.plus )
- Maps ( com.google.android.apps.maps )
- Play Banca ( com.google.android.apps.magazines )
- Play Filmes ( com.google.android.videos )
- Play Games ( com.google.android.play.games )
- Play Livros ( com.google.android.apps.books )
- Play Música ( com.google.android.music )