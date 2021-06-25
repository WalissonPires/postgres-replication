-- init database

CREATE DATABASE micro1;

\c micro1;

CREATE TABLE public.categories(
   id SERIAL PRIMARY KEY,
   name varchar(50) NOT NULL
);

CREATE TABLE public.brands(
   id SERIAL PRIMARY KEY,
   description varchar(50) NOT NULL
);

CREATE TABLE public.products(
   id SERIAL PRIMARY KEY,
   description varchar(100) NOT NULL,
   stock FLOAT NOT NULL,
   brand_id INTEGER,
   category_id INTEGER,

   FOREIGN KEY (brand_id) REFERENCES brands(id),
   FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO brands (name) VALUES ('other');
INSERT INTO categories (name) VALUES ('other');
INSERT INTO products (description, stock, brand_id, category_id) VALUES ('teclado', 10, 1, 1);


-- configure replication

---- Install extension
CREATE EXTENSION pglogical;

---- Create node
SELECT pglogical.create_node(
   node_name := 'micro1_provider',
   dsn := 'host=micro1 port=5432 dbname=micro1 password=masterkey'
);

---- Set replication tables (all tables from public scheme)
SELECT pglogical.replication_set_add_all_tables('default', ARRAY['public']);


-- utils

-- Criar tabela local e nos assinantes
select pglogical.replicate_ddl_command('CREATE TABLE public.brands(
   id SERIAL PRIMARY KEY,
   description varchar(50) NOT NULL
);');

-- Adicionar tabela para replicação
select pglogical.replication_set_add_table('default', 'public.brands');

-- Remover tabela da replicação
select pglogical.replication_set_remove_table('default', 'public.brands');