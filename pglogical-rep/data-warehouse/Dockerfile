#FROM p404/docker-pglogical

#RUN echo "host  micro1  postgres  data-warehouse/32  trust" >> /var/lib/postgresql/data/pg_hba.conf

FROM pglogical:latest

RUN echo "shared_preload_libraries = 'pglogical'" >> /usr/share/postgresql/postgresql.conf.sample

#COPY init.sql /docker-entrypoint-initdb.d/init.sql