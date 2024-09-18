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
!!! info
    Para versões do MySQL inferiores a v8, pode-se utilizar o seguinte:
    ~~~sql
    CREATE INDEX nome_do_indice ON nome_da_tabela (nome_da_coluna)
    ~~~

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
