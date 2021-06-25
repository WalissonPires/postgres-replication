-- init database

CREATE DATABASE micro2;

\c micro2;

CREATE TABLE public.customers(
   id SERIAL PRIMARY KEY,
   name varchar(100) NOT NULL
);

INSERT INTO customers (name) VALUES ('Rin');


-- configure replication

---- Install extension
CREATE EXTENSION pglogical;

---- Create node
SELECT pglogical.create_node(
   node_name := 'micro2_provider',
   dsn := 'host=micro2 port=5432 dbname=micro2 password=masterkey'
);

---- Set replication tables (all tables from public scheme)
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public']);