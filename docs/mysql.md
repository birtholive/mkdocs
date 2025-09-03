# Comandos SQL

## Visualizar todas as tabelas de um banco e suas propriedades
```sql
SELECT * 
FROM INFORMATION_SCHEMA.TABLES 
```
## Visualizar colunas de uma tabela e suas propriedades
```sql
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'nome_da_tabela'
```

## Compactar tabelas no MySQL
```sql
ALTER TABLE schema.table_name 
ENGINE = InnoDB ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4
```

## Insert
```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...); 
```

## Update
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; 
```

## Delete
```sql
DELETE FROM table_name 
WHERE condition
```

## Index
```sql
ALTER TABLE <tabela> 
ADD index (<coluna>)
```

## Index Composto
```sql
ALTER TABLE <tabela> 
ADD index nome_index (<coluna1>, <coluna2>,...,<coluna_n>)
```

## Auto Increment
```sql
ALTER TABLE <tabela>
CHANGE COLUMN `id` 'ID' int(11) NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (`ID`);
```
!!! tip "Dica"
    O valor do auto_increment pode ser iniciado a partir de qualquer número. Por ex:
    ```sql
    ALTER TABLE `<tabela>`
    AUTO_INCREMENT=777;
    ```

## Modificar o tipo de dado de uma colula
Caso queira modificar o tipo de dado de uma coluna, utilize o código a seguir:
```
ALTER TABLE nome_da_tabela MODIFY COLUMN nome_da_coluna VARCHAR(50) NULL;
```

## Cláusula HAVING
A cláusula HAVING em SQL é usada para filtrar os resultados de uma consulta após a aplicação da cláusula GROUP BY. Ela é especialmente útil quando você precisa aplicar condições em valores agregados, algo que a cláusula WHERE não pode fazer. Aqui está um exemplo:
~~~sql
SELECT department, SUM(salary)
FROM employees
GROUP BY department
HAVING SUM(salary) > 50000;
~~~

## Exemplos de consulta
### Acumular valores de uma coluna no MySQL 5.x
```sql
SELECT
	t.periodo
	, t.cnpj
	, t.nome_fantasia
	, t.linhas_net
	, @acumulado := IF(@prev_cnpj = t.cnpj , @acumulado + t.linhas_net , t.linhas_net) AS linhas_acumulado
	, @prev_cnpj := t.cnpj --> este parametro é necessário para que o acumulado seja calculado corretamente
FROM
	(
	SELECT
		b.periodo
		, se.empresa_cnpj AS cnpj
		, se.empresa_nome_fantasia AS nome_fantasia
		, COALESCE(SUM(b.qtde_linhas_adicionadas) - SUM(b.qtde_linhas_canceladas), 0) AS linhas_net
	FROM
		billing b
	JOIN sat_empresas se ON
		se.empresa_id = b.empresa_id
	WHERE
		se.empresa_nome_fantasia IN('granito', 'defender')
	GROUP BY
		se.empresa_cnpj
		, b.periodo
	ORDER BY
		se.empresa_cnpj
		, b.periodo) t
	,
    (
	SELECT
		@acumulado := 0
		, @prev_cnpj := '') AS vars;
```
### Acumular valores de uma coluna no MySQL 8+
#### Método 1: Sem WITH
~~~sql
SELECT
    b.periodo,
    se.empresa_cnpj AS cnpj,
    se.empresa_nome_fantasia AS nome_fantasia,
    COALESCE(SUM(b.qtde_linhas_adicionadas) - SUM(b.qtde_linhas_canceladas), 0) AS linhas_net,
    SUM(COALESCE(SUM(b.qtde_linhas_adicionadas) - SUM(b.qtde_linhas_canceladas), 0)) OVER (PARTITION BY se.empresa_cnpj ORDER BY b.periodo) AS linhas_net_acumuladas
FROM
    billing b
JOIN sat_empresas se ON se.empresa_id = b.empresa_id
GROUP BY
    se.empresa_cnpj, b.periodo, se.empresa_nome_fantasia
ORDER BY
    se.empresa_cnpj, b.periodo;
~~~

#### Método 2: Com WITH
~~~sql
WITH linhas_net_calculadas AS (
    SELECT
        b.periodo,
        se.empresa_cnpj AS cnpj,
        se.empresa_nome_fantasia AS nome_fantasia,
        COALESCE(SUM(b.qtde_linhas_adicionadas) - SUM(b.qtde_linhas_canceladas), 0) AS linhas_net
    FROM
        billing b
    JOIN sat_empresas se ON se.empresa_id = b.empresa_id
    GROUP BY
        se.empresa_cnpj, b.periodo, se.empresa_nome_fantasia
),
linhas_net_acumuladas AS (
    SELECT
        periodo,
        cnpj,
        nome_fantasia,
        linhas_net,
        SUM(linhas_net) OVER (PARTITION BY cnpj ORDER BY periodo) AS linhas_net_acumuladas
    FROM
        linhas_net_calculadas
)
SELECT
    periodo,
    cnpj,
    nome_fantasia,
    linhas_net,
    linhas_net_acumuladas
FROM
    linhas_net_acumuladas
ORDER BY
    cnpj, periodo;

~~~

## Converter decimal para formato de ip
Para converter um número decimal em um formato de IP (IPv4), você precisa seguir alguns passos simples. Um endereço IP é composto por quatro octetos, cada um representando um número entre 0 e 255. Aqui está como você pode fazer isso:

Divida o número decimal: O número decimal deve ser dividido em quatro partes, cada uma representando um octeto. Para isso, você pode usar a divisão sucessiva por 256.

Calcule os octetos:

1. O primeiro octeto é obtido dividindo o número por (256^3) (ou 16777216).
2. O segundo octeto é obtido dividindo o restante por (256^2) (ou 65536).
3. O terceiro octeto é obtido dividindo o restante por (256^1) (ou 256).
4. O quarto octeto é o restante final.

Exemplo: Vamos converter o número decimal 3232235776.

* Primeiro octeto: (3232235776 \div 16777216 = 192)
* Segundo octeto: ((3232235776 \mod 16777216) \div 65536 = 168)
* Terceiro octeto: ((3232235776 \mod 65536) \div 256 = 1)
* Quarto octeto: (3232235776 \mod 256 = 0)

Portanto, 3232235776 em formato de IP é 192.168.1.0.

No MySQL, você pode usar as funções INET_ATON e INET_NTOA para converter entre a forma legível e binária de endereços IPv4. Para IPv6, use INET6_ATON e INET6_NTOA.

IPv4:
~~~sql
SET @ip = INET_ATON('127.0.0.1');
SELECT INET_NTOA(@ip);
~~~

Exemplo:
~~~sql
SELECT
	sl.linhas_gsm AS GSM
	,inet_ntoa(linhas_endereco_ip) AS IP
FROM
	sat_linhas sl
~~~

IPv6 (disponível em MySQL 5.6.3+):
~~~sql
SET @ip6 = INET6_ATON('::1');
SELECT INET6_NTOA(@ip6);
~~~