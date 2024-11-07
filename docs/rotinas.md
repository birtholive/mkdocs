# Outras rotinas
## Gerar faturas não criadas
Esta rotina deve ser executada quando, durante o processo de faturamento, as faturas não forem geradas para todos os contratos do período em questão. Para executar esta rotina, abra o Pentaho no servidor e execute o processo localizado no caminho indicado abaixo, informando o ciclo correspondente às faturas como parâmetro.
`D:\ETLs\Billing\billing\t_cobranca_recorrente_iugu_manual.ktr`. 

Você também pode gerar as faturas de forma individual pelo navegador de internet, substituindo o texto ID_BILLING na url, pelo id do billing da fatura a ser gerada.
```
http://172.31.245.137:2804/1/iugu/cobranca/billing?id=ID_BILLING&bp=1
```
## Revisão dos gatilhos iugu
Esta rotina consiste em reenviar os gatilhos que tiveram algum erro na api da iugu, para atualizar as tabelas do SETH e gerar os alertas que são enviados ao financeiro.

Para reenviar o gatilho, acesse o [site da iugu](https://alia.iugu.com/) e selecione o intervalo de tempo.
```
https://alia.iugu.com/
```   
## Pedidos de migração de linhas
 Os pedidos consistem em gerar um número de pedido e atribuir esse numero às linhas migradas de um contrato A para um contrato B. Estes pedidos são solicitados no **Zendesk** e processados pelo Pentaho.Para realizar essa migração basta seguir os passos a seguir:

* Verifique as todas as informações sobre o pedido no [Zendesk](https://koretmdata.zendesk.com/agent/dashboard) 
* No servidor<sup>1</sup> do pentaho, abra o arquivo Linhas.csv<sup>2</sup> e informe os valores de linhas, ticket, contrato_origem, contrato_destino e solicitante
* Rode o job migraLinhas.kjb<sup>3</sup>

!!! tip "Dicas"
    1. O servidor do pentaho pode ser acessado a partir do ip `172.31.245.79` 
    2. A planilha linhas fica no seguinte endereço do servidor: `D:\ETLs\MigraLinhas\arquivos\Linhas.csv`
    3. O Job MigraLinhas fica no seguinte endereço do servidor: `D:\ETLs\MigraLinhas\migraLinhas.kjb`
## Reports Power BI
### Acompanhamento de vendas
Report de vendas com os principais indicadores distribuidos por tempo, território e operadora

- Venda Padrão
- Venda Linha
- Venda Chip
- Cancelamentos
- Linhas Suspensas
- NET SIM's

## Reports Excel
### Relatório operadoras
Existem dois reports que são requeridos pela Anatel. Um mensal que roda automaticamente e outro semestral que é feito de forma manual. A consulta a seguir gera o report semestral. Este deve ser exportado para o excel e enviado para a Anatel.

O arquivo pode ser encontrado no seguinte endereço: `\Repositório KORE BR - Documentos\03 Tech & Operational\04 Process & Systems\Systems\Reports\Report Semestral Anatel.xlsx`
~~~sql
(SELECT
	'' AS CN,
	'Receita_Operacional_Líquida_ROL' AS DADO_INFORMADO,
	'SCM' AS SERVICO,
	se.empresa_uf AS UNIDADE_DA_FEDERACAO_UF,
	IF(SUM(b.total_a_pagar) IS NULL, 0, SUM(b.total_a_pagar)) AS VALORES,
	'24.492.478/0001-44' AS CNPJ,
	CASE
		WHEN RIGHT(b.periodo,2)<=3 THEN concat('31/03/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=6 THEN concat('30/06/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=9 THEN concat('30/09/',LEFT(b.periodo,2))
		ELSE concat('31/12/',LEFT(b.periodo,2))
	END AS DATA
FROM
	billing b
JOIN
	sat_empresas se ON se.empresa_id = b.empresa_id
WHERE
	b.periodo >= 2001
	AND b.codigo_faturamento IN(2,4)
GROUP BY
	UNIDADE_DA_FEDERACAO_UF, DATA)
UNION 
(SELECT
	'' AS CN,
	'Tráfego_Dados_Total_MB' AS DADO_INFORMADO,
	'SCM' AS SERVICO,
	se.empresa_uf AS UNIDADE_DA_FEDERACAO_UF,
	IF(SUM(b.dados_utilizados) IS NULL, 0,SUM(b.dados_utilizados))  AS VALORES,
	'24.492.478/0001-44' AS CNPJ,
	CASE
		WHEN RIGHT(b.periodo,2)<=3 THEN concat('31/03/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=6 THEN concat('30/06/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=9 THEN concat('30/09/',LEFT(b.periodo,2))
		ELSE concat('31/12/',LEFT(b.periodo,2))
	END AS DATA
FROM
	billing b
JOIN
	sat_empresas se ON se.empresa_id = b.empresa_id
WHERE
	b.periodo >= 2001
	AND b.codigo_faturamento IN(2,4)
GROUP BY
	UNIDADE_DA_FEDERACAO_UF, DATA)
UNION 
(SELECT
	'' AS CN,
	'Capital_Expenditure_CAPEX' AS DADO_INFORMADO,
	'SCM' AS SERVICO,
	se.empresa_uf AS UNIDADE_DA_FEDERACAO_UF,
	0 AS VALORES,
	'24.492.478/0001-44' AS CNPJ,
	CASE
		WHEN RIGHT(b.periodo,2)<=3 THEN concat('31/03/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=6 THEN concat('30/06/',LEFT(b.periodo,2))
		WHEN RIGHT(b.periodo,2)<=9 THEN concat('30/09/',LEFT(b.periodo,2))
		ELSE concat('31/12/',LEFT(b.periodo,2))
	END AS DATA
FROM
	billing b
JOIN
	sat_empresas se ON se.empresa_id = b.empresa_id
WHERE
	b.periodo >= 2001
	AND b.codigo_faturamento IN(2,4)
GROUP BY
	UNIDADE_DA_FEDERACAO_UF, DATA)
ORDER BY 
	UNIDADE_DA_FEDERACAO_UF, DATA, DADO_INFORMADO
~~~
### Quantidade de linhas por periodo
Este report contém a quantidade de linhas por cliente ao longo dos periodos. É exportado para o excel, organizado por periodo numa tabela dinâmica e enviado para os gestores.

O report pode ser encontrado no seguinte caminho do repositório (sharepoint): `\Repositório KORE BR - Documentos\03 Tech & Operational\04 Process & Systems\Systems\Reports\qtde_linhas_por_periodo.xlsx`. A seguir está a consulta utilizada no arquivo excel para retornar os dados. 

!!! info "IMPORTANTE"
    Para atualizar a planilha, basta abrir o arquivo, clicar bom o botão direito sobre a planilha **dados** e clicar em atualizar.
~~~sql
SELECT
	se.empresa_id ID,
	se.empresa_nome_fantasia NOME,
	periodo PERIODO,
	SUM(qtde_linhas_adicionadas) ADICIONADAS,
	SUM(qtde_linhas_canceladas) CANCELADAS,
	SUM(qtde_linhas_adicionadas)-SUM(qtde_linhas_canceladas) NET,
	SUM(qtde_total_linhas) QTD_LINHAS
FROM
	billing b, sat_empresas se
WHERE
	periodo >= 2205 -- escolha o periodo que você quer iniciar a avaliação
	AND b.empresa_id = se.empresa_id
GROUP BY
        b.periodo, se.empresa_id
~~~

### Consumo das linhas
Relatório do consumo das linhas por contrato, operadora, status do contrato, status da linha e tipo de franquia.
~~~sql
SELECT
	sl.linhas_gsm AS GSM
	, sl.chips_iccid AS ICCID
	, sc.contrato_numero AS CONTRATO
	, sp.plano_nome AS PLANO
	, sl.linhas_operadora AS OPERADORA
	, UPPER(sc.contrato_ativo) AS STATUS_CONTRATO
	,CASE
    	WHEN sp.plano_id = 352 THEN "SUSPENSO"
     	ELSE UPPER(sl.linhas_status_cliente)
	 END AS STATUS_LINHA
	, sp.plano_tipo_franquia AS TIPO_FRANQUIA
	, a.CONSUMO_BYTES
FROM
	(SELECT
		linha_id 
		, contrato_id
		, SUM(consumo_total_bytes) AS CONSUMO_BYTES
	FROM accounting.consumo_diario_${ciclo}
	WHERE 
		DATE(DATA) = LEFT(DATE_ADD(NOW(), INTERVAL -1 DAY),10)
	GROUP BY contrato_id, linha_id) a
JOIN sat.sat_linhas sl ON sl.linhas_id = a.linha_id
JOIN sat.sat_contrato sc ON sc.contrato_id = sl.linhas_contrato_id
JOIN sat.sat_plano sp ON sp.plano_id = sc.plano_id 
WHERE 
	sc.empresa_id = ${empresa_id}
~~~
### Relatório ENTERPRISE
Relatório gerado todo mês e deve ser enviado para o repositório da Kore no Sharepoint

## Desbloqueio automático das linhas
Este processo consiste no desbloqueio de todas as linhas que foram bloqueadas no periodo anterior. É executado de forma automática, toda madrugada do dia 24 de cada mês. Caso haja algum problema com o integrador, o processo pode ser interrompido, necessitando ser executado de forma manual. 

!!!info "IMPORTANTE"
	Este processo pode ser executado manualmente sem nenhuma configuração prévia que não causará problemas.

## Dias utilizados pelas linhas
Processo que verifica os dias utilizados pelas linhas durante o período.
Para executar este processo, siga os passos a seguir:

1. Acesse o servidor do pentaho e informe as linhas no arquivo Base.xlsx localizado no seguinte endereço `D:\ETLs\DEV\DiasUtilizadosPorLinha\Base.xlsx` 
2. Abra o Pentaho Data Integration
3. Abra o arquivo DiasUtilizadosNew.ktr localizado no seguinte caminho `D:\ETLs\DEV\DiasUtilizadosPorLinha\DiasUtilizadosNew.ktr`
4. Execute-o, passando os parâmetros correspondentes ao ciclo avaliado.

## Migração Automática
Migração automática das linhas do plano livre que atingiram o limite máximo de consumo ou de tempo. Quando atingem esse limite, a linha migra para o contrato de cobrança definido previamente.

## Suspensão Inteligente
Processo que verifica as linhas suspensas e migra para o contrato de cobrança quando atingem o tempo máximo que a linha deve ficar em suspensão.

