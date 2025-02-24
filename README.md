# Projeto Dockerized Library API

Este projeto é uma aplicação de exemplo que utiliza **Docker** e **Docker Compose** para orquestrar três containers:
- **API** (Node.js) que conecta ao banco de dados MySQL.
- **Banco de Dados** (MySQL) que armazena informações sobre livros.
- **Website** (PHP) que exibe os livros na interface web.

## O que é Docker e seus componentes principais?

Docker é uma plataforma que permite criar, distribuir e executar aplicações em containers. Ele facilita a construção de ambientes isolados e portáteis, garantindo que uma aplicação funcione de maneira consistente em diferentes sistemas operacionais e infraestruturas.

### Imagem Docker

Uma imagem Docker é um modelo de leitura que contém o código-fonte e as dependências de uma aplicação. Imagens podem ser usadas para criar containers, ou seja, instâncias executáveis de uma aplicação.

### Container Docker

Um container Docker é uma instância em execução de uma imagem Docker. Ele possui seu próprio sistema de arquivos, rede e processos. Quando você executa o comando `docker compose up -d`, o Docker cria containers a partir das imagens especificadas no arquivo `docker-compose.yml`.

### Docker Compose

Docker Compose é uma ferramenta que permite definir e rodar aplicações multi-container. Com o arquivo `docker-compose.yml`, podemos configurar os serviços (containers) necessários para o projeto e orquestrar a execução de todos eles com um único comando.

## Tecnologias usadas
- **PHP**: Front-end.
- **Node.js**: API.
- **MySql**: Banco de dados.
- **Docker**: Containers.
- **Docker Compose**: Gerenciamento dos containers.

## Estrutura de Diretórios

- **api/**: Diretório da API.
  - **db/**: Scripts de banco de dados.
  - **src/**: Código-fonte da API (`index.js`).
  - **package.json**: Dependências da API Node.js.
- **website/**: Diretório do site PHP.
  - **index.php**: Arquivo principal do site.
  - **css/**: Pasta que contém o arquivo de estilo **`style.css`** para o site PHP.
- **docker-compose.yml**: Arquivo para orquestração de containers.
- **README.md**: Documentação do projeto.

## Requisitos

- **Docker**: Certifique-se de ter o Docker instalado no seu sistema.
- **Docker Compose**: Usado para orquestrar múltiplos containers de forma fácil.

## Como usar

1. Clone este repositório para o seu computador local, com o comando:
```sh
git clone https://github.com/JoaoM9081/Docker_api_book.git
```

### Iniciar os Containers

Para rodar os containers, execute o comando abaixo:
```sh
docker compose up -d
```

### Verificar o Status dos Containers

Você pode verificar se os containers estão rodando corretamente usando o comando:
```sh
docker ps
```

### Acessando as APIs

1. **Acesse API Node.js**:
  Abra o navegador e vá para:
   ```
   http://localhost:9001/books
   ```

2. **Acesse o front-end**:
   Abra o navegador e vá para:
   ```
   http://localhost:8888
   ```

3. **Parar os containers**:
   ```bash
   docker-compose down
   ```

### Acessando o Banco de dados

Caso queira usar comandos SQL como INSERT, UPDATE, DELETE para modificar o banco, execute os comandos:
```sh
docker exec -it mysql-container /bin/bash
mysql -uroot -ppasswordroot
```

## Explicação do `docker-compose.yml`
O arquivo `docker-compose.yml` define como os containers serão configurados e como eles se comunicam.

```yaml
version: "3.8" # Define a versão do Docker Compose utilizada.
services:
  db:
    image: mysql:8 # Utiliza a imagem do MySQL versão 8.
    container_name: mysql-container # Define um nome personalizado para o container.
    environment:
      MYSQL_ROOT_PASSWORD: passwordroot # Define a senha do usuário root.
      MYSQL_DATABASE: biblioteca # Cria um banco de dados chamado "biblioteca".
    volumes:
      - mysql-data:/var/lib/mysql # Armazena os dados do banco para persistência.
      - ./api/db/script.sql:/docker-entrypoint-initdb.d/script.sql # Importa um script SQL na inicialização.
    ports:
      - "3306:3306" # Mapeia a porta do MySQL para acesso externo.
    restart: always # Garante que o container reinicie automaticamente se falhar.
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"] # Testa se o MySQL está rodando.
      interval: 5s # Intervalo entre os testes.
      timeout: 10s # Tempo máximo de resposta.
      retries: 5 # Número máximo de tentativas antes de considerar que o container falhou.

  api:
    image: node:18-slim # Utiliza a imagem do Node.js versão 18.
    container_name: node-container # Nome do container para a API.
    working_dir: /home/node/app # Define o diretório de trabalho dentro do container.
    restart: always # Reinicia automaticamente se houver falha.
    volumes:
      - ./api:/home/node/app # Monta o diretório local da API dentro do container.
    ports:
      - "9001:9001" # Expõe a API na porta 9001.
    depends_on:
      db:
        condition: service_healthy # Aguarda o banco de dados estar pronto antes de iniciar a API.
    environment:
      - DB_HOST=db # Define o nome do serviço de banco de dados.
      - DB_USER=root # Define o usuário do banco de dados.
      - DB_PASSWORD=passwordroot # Define a senha do banco de dados.
    command: >
     sh -c "npm install --include=dev && npm install -g nodemon && npm start" # Instala dependências e inicia a API.

  web:
    image: php:8.2-apache # Utiliza a imagem do PHP com Apache embutido.
    container_name: php-container # Define o nome do container.
    working_dir: /var/www/html # Define o diretório de trabalho dentro do container.
    restart: always # Reinicia automaticamente em caso de falha.
    volumes:
      - ./website:/var/www/html # Monta o diretório local do site dentro do container.
    ports:
      - "8888:80" # Expõe o site PHP na porta 8888.
    depends_on:
      - db # Garante que o banco de dados esteja pronto antes de iniciar o site.
      - api # Aguarda a API estar pronta antes de iniciar o site.

volumes:
  mysql-data: # Volume para persistência dos dados do MySQL.
```
