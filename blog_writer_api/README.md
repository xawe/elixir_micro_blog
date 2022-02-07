# BlogWriterApi


## Definição

Implementação de api para escrita only.



## Infra

# Dependências

 - Redis
    
    * Executar o `docker-compose up -d` no arquivo /infrastructure/docker-compose

    * Para rodar usando debug, será necessário mudar o ip do arquivo de property, indicando o ip do container Redis - `docker inspect red-cache`

    * Ou usar `MIX_ENV=dev iex -S mix` ou `MIX_ENV=prod iex -S mix` para construir uma imagem e rodar a aplicação dentro de um container, usando a network `micro-space-network` utiliada pela infraestrutura 


