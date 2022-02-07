# BlogWriterApi


## Definição

Implementação de api para escrita only.



# Infra

## Dependências

    - Redis
    
        * Executar o `docker-compose up -d` no arquivo /infrastructure/docker-compose

        * Para rodar usando debug, será necessário mudar o ip do arquivo de property, indicando o ip do container Redis - `docker inspect red-cache`

        * Ou usar `MIX_ENV=dev iex -S mix` ou `MIX_ENV=prod iex -S mix` para construir uma imagem e rodar a aplicação dentro de um container, usando a network `micro-space-network` utiliada pela infraestrutura

## Docker

    - Utilize o comando abaixo para gerar uma nova imagem
    
      `docker image build -t xawe/blog-writer-api .`

    - Utilize o comando abaixo para gerar um novo container

      `docker container run -dp 8000:8000 --network micro-space-network --network-alias blog-writer-api --name blog-writer xawe/blog-writer-api 
`



