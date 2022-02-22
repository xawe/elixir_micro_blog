# BlogDataWriterServer

**TODO: Add description**


## Testes de depuração

  Para conectar a aplicação às dependências, será necessário:

  - Ou descobrir o ip de cada container com o comando `docker inspect` e configurar diretamente no arquivo /config/config.exs

  - Ou incluir os ips dos containeres no arquivo /etc/hosts

    1) abra o arquivo /etc/hosts com permissão root

    2) inclua as linhas `172.24.0.1 localhost` (importante, validar o ip dos containeres que pode estar com um range diferente)

    3) configurar as conexões no arquivo config/config.exs como localhost



Referencia [ElixirSchool](https://elixirschool.com/en/lessons/ecto/basics)
