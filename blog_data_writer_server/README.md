# BlogDataWriterServer

## Definição

Server responsável por escutar mensagens e persistir o conteudo no banco de dados, postando
na fila de retorno o se as informações foram armazenadas com sucesso ou não


# Infra

## Dependências
  
  - PostgreSql
  - RabbitMQ   

## Docker

* Subir a infraestrutura via arquivo /infrastructure/docker-compose               

  > docker-compose up -d


* Subindo a aplicação

  - Para rodar usando debug, será necessário mudar o ip do arquivo de property, indicando o ip do container Redis - 
        
    > docker inspect red-cache

  - Ou para construir uma imagem e 
    rodar a aplicação dentro de um container, usando a network `micro-space-network` utilizada 
    pela infraestrutura, execuar

    > MIX_ENV=dev

    > MIX_ENV=prod    

    > docker image build -t xawe/blog-writer-data .

  - e para criar um novo container
      
    > docker container run  --network micro-space-network --network-alias blog-writer-api --name blog-writer-data xawe/blog-writer-data

# Sobre banco de dados de produção

  Caso suba a aplicação pela primeira vez usando o profile prod, executar o `MIX_ENV=prod mix.ecto create` e `MIX_ENV=prod mix ecto.migrate` para criar o banco de dados de produção e executar as migrations
  

## Testes de depuração

  Para conectar a aplicação às dependências, será necessário:

  - Ou descobrir o ip de cada container com o comando `docker inspect` e configurar diretamente no arquivo /config/config.exs

  - Ou incluir os ips dos containeres no arquivo /etc/hosts

    1) abra o arquivo /etc/hosts com permissão root

    2) inclua as linhas `172.24.0.1 localhost` (importante, validar o ip dos containeres que pode estar com um range diferente)

    3) configurar as conexões no arquivo config/config.exs como localhost



Referencia [ElixirSchool](https://elixirschool.com/en/lessons/ecto/basics)
