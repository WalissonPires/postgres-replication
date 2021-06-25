
# Postgres replication
    https://www.postgresql.org/docs/9.3/warm-standby.html (replicação fisica)
    https://www.postgresql.org/docs/current/logical-replication.html (replicação lógica)
    https://www.postgresql.org/docs/10/logical-replication-config.html
    https://www.postgresql.org/docs/10/logical-replication-quick-setup.html
    https://hevodata.com/learn/postgresql-logical-replication/

- Replicating Postgres inside Docker — The How To
    https://medium.com/@2hamed/replicating-postgres-inside-docker-the-how-to-3244dc2305be

- Replicação fisica nativa esquemas:
    Master -> Slave1, SlaveN
    Master1 -> Master2 -> Slave1, SlaveN


# Replicação lógica (Extensão pglogical) (Usando padrão de publicação/assinatura)
    https://github.com/2ndQuadrant/pglogical
    https://www.2ndquadrant.com/en/blog/pglogical-logical-replication-postgresql-10/ (plugin vs native)

- Permite um server receber dados de varios outros servidores

- Docker imagens
    https://hub.docker.com/r/p404/docker-pglogical/dockerfile
    https://github.com/juxtin/docker-pglogical

- Problema de conflitos
  https://www.postgresql.org/message-id/156985841500.26192.10947730992115987072%40wrigleys.postgresql.org


pglogical (extensão)
 - P: Resolução de conflitos
 - N: Se a tabela é removida da replicação e adicionada novamente mais tarde. Os dados do intervalo não são baixados (O mesmo quando a tabela é adicionar pela primeira vez e já possui dados)
  OBS.: Quando adicionar pela primeira vez chamar alter_subscription_synchronize (Somente antes da replicação iniciar) ou alter_subscription_resynchronize_table (Apagar tudo se já tiver replicado algo) baixa os dados;
 - P: Aplica DDL no provedor e nos assinantes
 - N: Não replica novas tabelas auto. (Da pra fazer com uma trigger)

pgnativo
 - N: Não resolve conflitos (Interrompe a replição e não continua até resolver manualmente)
 - N: Não replica DDL (Tem que executar o mesmo script manualmente e cada assinante)
 - P: Novas tabelas são replicadas automaticamente
 - P: Replica dados ao adicionar nova tabela a aplicação
 - N: Sempre que a pulicação mudar e preciso que os assinantes executem um comando para atualizar a assinatura
 - N: Remover uma tabela da sincronização e adicionar novamente faz com que todos os dados sejam baixados novamente (Como se fosse a primeira vez). Mas não replica porque da conflito de PK. (E ferra tudo)

ambos
 - Replica os dados apos desligamento