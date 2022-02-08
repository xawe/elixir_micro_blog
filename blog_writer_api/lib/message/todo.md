Cria estrutura

# Obter o chanel declarado 

{:ok, chan} = AMQP.Application.get_channel(:mychan)


# Declarar a Exchange

ler docs sobre tipo de exchange

AMQP.Exchange.declare(chan, "my_ex",:fanout)


# Declarar queue

AMQP.Queue.declare(chan, "my_queue", []:durable])


# Bind exchange a queue

AMQP.Queue.bind(chan, "my_queue", "my_ex")


# Publicar mensagem simples

AMQP.Basic.publish(chan, "my_ex", "", "hello")