# Rotinas de execução do billing
O billing é o processo que calcula o total que cada cliente deverá pagar. Ele é calculado por contrato, considerando o plano, quantidade de linhas e consumo que o cliente possuia no periodo analisado para o contrato em questão.
## Billing LoRa
Deve ser processado no primeiro dia de cada mês

Perguntar ao Lucas Ramos se os dados da API estão disponíveis

Rodar billing lora (primeira parte) informando o período atual (ultimo no banco + 1). Verificar ultimo periodo no banco:
~~~sql
SELECT DISTINCT periodo
FROM lora_billing
ORDER BY periodo DESC;
~~~
Verificar houve alguma inconsistencia no periodo em que foi rodado (se houver, enviar para Lucas que dirá se será necessário fazer todo o processo novamente)

Com tudo certo, rodar a segunda parte do billing.
!!! tip "Dica"
    * Tecnologia LoRa: LoRa (long range) é uma tecnologia de radiofrequência de longo alcance e baixa potência, ideal para a Internet das Coisas (IoT)1.
    * Aplicações: Utilizada em cidades inteligentes, agronegócio, medição inteligente, logística e mais, com mais de 191 milhões de dispositivos conectados.
    * Vantagens: Oferece longo alcance, baixo consumo de energia e transmissão segura de dados, superando limitações de redes celulares e Wi-Fi.
    * Ecossistema: Suportada por uma ampla rede de operadoras, fabricantes e provedores de serviços, permitindo soluções IoT escaláveis e lucrativas.

    Clique [aqui](https://consultimer.com/o-que-e-lora-conheca-a-tecnologia-de-radiofrequencia-de-longo-alcance/) para mais informações.

## Billing Conectividade
O processo de ETL roda automaticamente na madrugada do dia 24 de cada mês

!!! warning "Atenção"
    1. É importante que o billing rode na madrugada para que nenhum pedido seja finalizado no dia 24 antes da execução do processo e entre no calculo de billing. 
    2. Verifique se as faturas foram todas geradas corretamente (um email deve chegar com essa informação)

## Regras billing LoRa
### Cobrança Ativações
~~~js
cobranca_ativacoes = variacao_mensal_dispositivos * anuidade_mes_prorata;
anuidade_mes_prorata = prorata_mensalidade * meses_restantes_anuidade;
prorata_mensalidade = valor_anuidade / 12;
~~~

### Cobrança Total
~~~js
cobranca_total = cobranca_ativacoes + cobranca_excedente + cobranca_plataforma + lancamentos_cobranca - lancamentos_desconto;
~~~