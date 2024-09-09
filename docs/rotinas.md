# Outras rotinas
## Gerar faturas não criadas
Essa é uma rotina que deve ser executada manualmente quando as faturas não foram criadas durante o processamento do billing. Nesse caso, as faturas são geradas uma por uma, substituindo o texto ID_BILLING na url, pelo id do billing da fatura a ser gerada.

    http://172.31.245.137:2804/1/iugu/cobranca/billing?id=ID_BILLING&bp=1

## Revisão dos gatilhos iugu
Esta rotina consiste em reenviar os gatilhos que tiveram algum erro na api da iugu, para atualizar as tabelas do SETH e gerar os alertas que são enviados ao financeiro.

Para reenviar o gatilho, selecione o intervalo de tempo, informe o seu token e faça o envio.
```
https://dev.iugu.com/reference/reenviar-gatilho-por-per%C3%ADodo
```
!!! warning "Importante"
    É necessario ter um token para conseguir realizar esse reenvio do gatilho.    
## Pedidos de migração de linhas
 Os pedidos consistem em gerar um número de pedido e atribuir esse numero às linhas migradas de um contrato A para um contrato B. Estes pedidos são solicitados no **Zendesk** e processados pelo Pentaho.Para realizar essa migração basta seguir os passos a seguir:

* Verifique as todas as informações sobre o pedido no [Zendesk](https://koretmdata.zendesk.com/agent/dashboard) 
* No servidor<sup>1</sup> do pentaho, abra a planilha Linhas<sup>2</sup> e informe os valores de linhas, ticket, contrato_origem, contrato_destino e solicitante
* Rode o job migraLinhas.kjb<sup>3</sup>
* Copie o texto do email que você recebeu e cole no chamado do Zendesk
* Envie o chamado informando o próximo responsável da fila

!!! tip "Dicas"
    1. O servidor do pentaho pode ser acessado a partir do ip `172.31.245.79` 
    2. A planilha linhas fica no seguinte endereço do servidor: `D:\ETLs\MigraLinhas\arquivos\Linhas.xlsx`
    3. O Job MigraLinhas fica no seguinte endereço do servidor: `D:\ETLs\MigraLinhas\migraLinhas.kjb`
## Reports Power BI
Em desenvolvimento
## Reports Excel
Em desenvolvimento