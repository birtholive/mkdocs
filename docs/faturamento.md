# Faturamento

## JSON Faturamento Conectividade (final do mês)
- Informar todos os contratos de exceções e o período a ser calculado, no arquivo .CSV ("D:\ETLs\SAT_BIS\Excecoes\Excecoes.csv")
- Abrir o Pentaho e executar o arquivo .ktr ("D:\ETLs\SAT_BIS\Excecoes\excecoes.ktr")
- Rodar o job SAT BIS ETL_KBR inserindo o periodo atual como parâmetro
- Conectar ao json gerado e verificar o arquivo Verifica JSON com Marcia

## JSON Faturamento LoRa
- Informar todas as exceções no arquivo .CSV ("D:\ETLs\SAT_BIS\Excecoes\Excecoes.csv")
- Abrir o Pentaho e executar o arquivo .ktr ("D:\ETLs\SAT_BIS\Excecoes\excecoes.ktr")
- Rodar Job_Billing_Lora (SAT_BIS\ETL LORA\)
Enviar para o financeiro o arquivo JSON por email.