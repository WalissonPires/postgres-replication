#FROM p404/docker-pglogical

#RUN echo "host  micro1  postgres  data-warehouse/32  trust" >> /var/lib/postgresql/data/pg_hba.conf

FROM pglogical:latest

# VOLUME /var/lib/postgresql/data # re-volume this so that the config file changes take???

RUN echo "host    all          postgres                0.0.0.0/0   trust" >> /usr/share/postgresql/11/pg_hba.conf.sample
RUN echo "host    all          postgres                ::1/128     trust" >> /usr/share/postgresql/11/pg_hba.conf.sample
RUN echo "listen_addresses = '*'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "shared_preload_libraries = 'pglogical'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "wal_level = 'logical'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_wal_senders = 20" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_replication_slots = 20" >> /usr/share/postgresql/postgresql.conf.sample

#COPY init.sql /docker-entrypoint-initdb.d/init.sql