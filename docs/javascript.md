# Exemplos JavaScript
## Máscara para CNPJ e CPF
Essa função aplica uma máscara de formatação a um valor numérico, transformando-o em um formato de CPF ou CNPJ, dependendo do número de dígitos.
O método replace com a expressão regular `/\D/g` remove todos os caracteres que não são dígitos (0-9).
### Exemplo 1
```js
function aplicarMascara(valor) {
    valor = valor.replace(/\D/g, ""); // Remove todos os caracteres não numéricos
    if (valor.length <= 11) {
        // Aplica máscara de CPF
        valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
        valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
        valor = valor.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
    } else {
        // Aplica máscara de CNPJ
        valor = valor.replace(/^(\d{2})(\d)/, "$1.$2");
        valor = valor.replace(/^(\d{2})\.(\d{3})(\d)/, "$1.$2.$3");
        valor = valor.replace(/\.(\d{3})(\d)/, ".$1/$2");
        valor = valor.replace(/(\d{4})(\d)/, "$1-$2");
    }
    return valor;
}
```
### Exemplo 2
~~~js
function aplicarMascara(valor) {
    valor = valor.replace(/\D/g, ""); // Remove todos os caracteres não numéricos
    if (valor.length <= 11) {
        // Aplica máscara de CPF
        valor = valor.replace(/(.{3})(.{3})(.{3})(.{2})/, "$1.$2.$3-$4");
    } else {
        // Aplica máscara de CNPJ
        valor = valor.replace(/(.{2})(.{3})(.{3})(.{4})(.{2})/, "$1.$2.$3/$4-$5");
    }
    return valor;
}
~~~
## Remover acentos
### Exemplo 1
~~~js
function removerAcentos(texto) {
    const mapearAcentos = {
        'á': 'a', 'à': 'a', 'ã': 'a', 'â': 'a', 'ä': 'a',
        'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
        'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
        'ó': 'o', 'ò': 'o', 'õ': 'o', 'ô': 'o', 'ö': 'o',
        'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
        'ç': 'c', 'ñ': 'n'
    };
    return texto.replace(/[áàãâäéèêëíìîïóòõôöúùûüçñ]/g, function(match) {
        return mapearAcentos[match];
    });
}

// Exemplo de uso
let texto = "Olá, mundo! É um prazer vê-lo.";
let resultado = removerAcentos(texto);
console.log(resultado);  // Saída: "Ola, mundo! E um prazer ve-lo."
~~~
### Exemplo 2
Essa função utiliza o método normalize com a forma “NFD” (Normalization Form Decomposition), que decompõe os caracteres acentuados em caracteres básicos e marcas de acentuação. Em seguida, a expressão regular /[\u0300-\u036f]/g remove essas marcas de acentuação.
~~~js
function removerAcentos(texto) {
    return texto.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
}

// Exemplo de uso
let textoComAcentos = "Olá, como você está?";
let textoSemAcentos = removerAcentos(textoComAcentos);
console.log(textoSemAcentos); // "Ola, como voce esta?"

~~~

## Remover caracteres especiais
~~~js
function removerCaracteresEspeciais(text) {
    // Substitui todos os caracteres que não são letras, números ou espaços por uma string vazia
    return text.replace(/[^A-Za-z0-9\s]/g, '');
}

// Exemplo de uso
let texto = "Olá, mundo! #JavaScript";
let resultado = removerCaracteresEspeciais(texto);
console.log(resultado);  // Saída: "Olá mundo JavaScript"

~~~
## Array
### Criando um array de frutas
~~~js
let frutas = ["Maçã", "Banana", "Laranja"];
~~~
### Acessando elementos do array
~~~js
console.log(frutas[0]); // Exibe "Maçã"
console.log(frutas[1]); // Exibe "Banana"
console.log(frutas[2]); // Exibe "Laranja"
~~~
### Adicionando um novo elemento ao array
~~~js
frutas.push("Manga");
console.log(frutas); // Exibe ["Maçã", "Banana", "Laranja", "Manga"]
~~~
### Removendo o último elemento do array
~~~js
frutas.pop();
console.log(frutas); // Exibe ["Maçã", "Banana", "Laranja"]
~~~
### Iterando sobre os elementos do array
~~~js
for (let i = 0; i < frutas.length; i++) {
  console.log(frutas[i]);
}
~~~
## Validar CPF
~~~js
function validarCPF(cpf) {
    cpf = cpf.replace(/[^\d]+/g, ''); // Remove caracteres não numéricos

    if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) {
        return false; // Verifica se o CPF tem 11 dígitos ou se todos os dígitos são iguais
    }

    let soma = 0;
    let resto;

    for (let i = 1; i <= 9; i++) {
        soma += parseInt(cpf.substring(i - 1, i)) * (11 - i);
    }

    resto = (soma * 10) % 11;

    if (resto === 10 || resto === 11) {
        resto = 0;
    }

    if (resto !== parseInt(cpf.substring(9, 10))) {
        return false;
    }

    soma = 0;

    for (let i = 1; i <= 10; i++) {
        soma += parseInt(cpf.substring(i - 1, i)) * (12 - i);
    }

    resto = (soma * 10) % 11;

    if (resto === 10 || resto === 11) {
        resto = 0;
    }

    if (resto !== parseInt(cpf.substring(10, 11))) {
        return false;
    }

    return true;
}

// Exemplo de uso
const cpf = "123.456.789-09";
console.log(validarCPF(cpf)); // Retorna true ou false

~~~
## Encontrando datas com RegEx
### Por grupos
Datas no formato **dd/MM/yyyy** e **d/M/yy**
~~~
/(\d{1,2})\/(\d{1,2})\/(\d{2,4})/gm
~~~
### Por data completa
Datas no formato **dd/MM/yyyy**
~~~
/\d{1,2}\/\d{2}\/\d{4}/gm
~~~
Datas no formato **dd/MM/yyyy** e **d/M/yy**
~~~
/\d{1,2}\/\d{1,2}\/\d{2,4}/gm
~~~

## Corrigir datas com RegEx
~~~js
var data = '1/02/80'// Try edit me
var regex = /(\d{1,2})\/(\d{1,2})\/(\d{2,4})/gm //deinição da função regex
var result = regex.exec(data); //execução da função na string
// separação do vetor resultado pelo indice
var dia = result[1]; 
var mes = result[2];
var ano = result[3];
//verifica se o dia contem menos de 2 caracteres
if(dia.length<2){
  dia = '0'+ dia;
}
//verifica se o mes contem menos de 2 caracteres
if(mes.length<2){
  mes = '0'+ mes;
}
//define o ano atual com apenas os dois ultimos digitos do ano
var ano_atual = (new Date()).getFullYear().toString().substr(2,2);
//verifica se o ano contem menos de 4 caracteres
if(ano.length<4){
    ano = ano > ano_atual ? '19'+ano : '20'+ano;
}
//recria a data com as informações corrigidsa
data_corrigida = dia+'/'+mes+'/'+ano
// Log to console
console.log(data_corrigida) // O resultado esperado é: 01/02/1980  
~~~

## Exemplo de função para manipular datas
!!!tip "Dica"
      - Utilize datas no formato **YYYY/MM/DD** no input de dados
~~~js
function gerarPeriodo(dataFim) {
    // Converte a data de string para objeto Date
    var dataPeriodo = new Date(dataFim);

	 // Verifica se a data é válida
    if (isNaN(dataPeriodo.getTime())) {
        throw new Error("Data inválida: " + dataFim);
    }
    
    // Adiciona 1 ao mês (mês é zero-indexado)
    dataPeriodo.setMonth(dataPeriodo.getMonth() + 1);
    
    // Obtém o ano da data final
    var anoCompleto = dataPeriodo.getFullYear(); // Obtém o ano completo
    var ano = String(anoCompleto).slice(-2); // Converte para string e pega os últimos dois dígitos

    // Obtém o mês seguinte à data final
    var mes = dataPeriodo.getMonth() + 1; // Adiciona 1 para o próximo mês

    // Formata o mês para ter sempre dois dígitos
    var mesFormatado = mes < 10 ? '0' + mes : String(mes);

    // Retorna o período no formato desejado
    var ciclo = String(ano) + mesFormatado;
    return ciclo;
}
~~~