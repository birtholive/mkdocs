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

## Cláusula HAVING
A cláusula HAVING em SQL é usada para filtrar os resultados de uma consulta após a aplicação da cláusula GROUP BY. Ela é especialmente útil quando você precisa aplicar condições em valores agregados, algo que a cláusula WHERE não pode fazer. Aqui está um exemplo:
~~~sql
SELECT department, SUM(salary)
FROM employees
GROUP BY department
HAVING SUM(salary) > 50000;
~~~