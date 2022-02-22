# BlogWriterApi


## Definição

Implementação de api para escrita only.



# Infra

## Dependências

  - Redis
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

    > docker image build -t xawe/blog-writer-api .

  - e para criar um novo container
      
    > docker container run -dp 8000:8000 --network micro-space-network --network-alias blog-writer-api --name blog-writer xawe/blog-writer-api 
