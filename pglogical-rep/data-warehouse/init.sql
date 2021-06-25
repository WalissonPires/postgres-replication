
-- Init database

CREATE DATABASE alldata;


-- Configure replication

---- Install extension
CREATE EXTENSION pglogical;

---- Create node
SELECT pglogical.create_node(
  node_name := 'data-warehouse-subcriber',
  dsn := 'host=data-warehouse port=5432 dbname=alldata password=masterkey'
);

---- Subscribe to micro1
SELECT pglogical.create_subscription(
  subscription_name := 'subscription_for_micro1',
  provider_dsn := 'host=micro1 port=5432 dbname=micro1 password=masterkey'
);

--SELECT pglogical.wait_for_subscription_sync_complete('subscription_for_micro1');

---- Subscribe to micro2
SELECT pglogical.create_subscription(
  subscription_name := 'subscription_for_micro2',
  provider_dsn := 'host=micro2 port=5432 dbname=micro2 password=masterkey'
);


-- utils

-- Sincronizar todas as tabelas que não estão sincronizadas
select pglogical.alter_subscription_synchronize('subscription_for_micro1', false);

-- Trunca a tabela e baixar todos os dados novamente
select pglogical.alter_subscription_resynchronize_table('subscription_for_micro1', 'brands');
