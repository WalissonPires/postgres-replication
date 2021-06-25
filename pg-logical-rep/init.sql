-- Micro 1
CREATE DATABASE micro1;

\c micro1;

CREATE TABLE public.categories(
   id SERIAL PRIMARY KEY,
   name varchar(50) NOT NULL
);

CREATE TABLE public.brands(
   id SERIAL PRIMARY KEY,
   name varchar(50) NOT NULL
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

CREATE TABLE public.stock_history(
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    value FLOAT NOT NULL,

    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO brands (name) VALUES ('other');
INSERT INTO categories (name) VALUES ('other');
INSERT INTO products (description, stock, brand_id, category_id) VALUES ('teclado', 10, 1, 1);


CREATE PUBLICATION db_all_tables FOR ALL TABLES;
CREATE PUBLICATION sync_tables FOR TABLE stock_history;

-- Micro 2

CREATE DATABASE micro2;

\c micro2;

CREATE TABLE public.customers(
   id SERIAL PRIMARY KEY,
   name varchar(100) NOT NULL
);

CREATE TABLE public.orders (
	id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	total FLOAT NOT NULL,

	FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE public.credits(
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    amount FLOAT NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE public.credits(
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    amount FLOAT NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(id)
);


INSERT INTO customers (name) VALUES ('Rin');
INSERT INTO orders (customer_id, total) VALUES (1, 2500);
INSERT INTO credits (customer_id, amount) VALUES (1, 600);


CREATE PUBLICATION db_all_tables FOR ALL TABLES;
CREATE PUBLICATION sync_tables FOR TABLE orders;
ALTER PUBLICATION sync_tables ADD TABLE credits;

-- Data Warehouse

CREATE DATABASE alldata;

CREATE SUBSCRIPTION micro1_sync_all
CONNECTION 'host=micro1 port=5432 dbname=micro1 password=masterkey'
PUBLICATION db_all_tables;

CREATE SUBSCRIPTION micro2_sync_all
CONNECTION 'host=micro2 port=5432 dbname=micro2 password=masterkey'
PUBLICATION db_all_tables;


CREATE SUBSCRIPTION micro1_sync_tables
CONNECTION 'host=micro1 port=5432 dbname=micro1 password=masterkey'
PUBLICATION sync_tables;

CREATE SUBSCRIPTION micro2_sync_tables
CONNECTION 'host=micro2 port=5432 dbname=micro2 password=masterkey'
PUBLICATION sync_tables;

ALTER SUBSCRIPTION micro2_sync_tables REFRESH PUBLICATION;



-- utils


ALTER SUBSCRIPTION micro2_sync_tables DISABLE;
ALTER SUBSCRIPTION micro2_sync_tables ENABLE;

SELECt * from pg_subscription;
SELECt * from pg_subscription_rel;
select * from pg_stat_subscription;
select * from pg_stat_replication;
select * from pg_replication_origin;
select * from pg_replication_origin_status;
select pg_replication_origin_progress('pg_16473', true);
select pg_replication_origin_advance('pg_16473', '0/1810952');

select * from pg_settings;