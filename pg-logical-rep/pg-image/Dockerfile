ARG PG_MAJOR=10
#/usr/share/postgresql/postgresql.conf.sample

FROM postgres:${PG_MAJOR}

# on publisher
RUN echo "wal_level = 'logical'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_replication_slots = 40" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_wal_senders = 40" >> /usr/share/postgresql/postgresql.conf.sample

# on subscriber
RUN echo "max_replication_slots = 40" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_logical_replication_workers = 40" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_worker_processes = 41" >> /usr/share/postgresql/postgresql.conf.sample

RUN echo "host    all      all      0.0.0.0/0   trust" >> /usr/share/postgresql/${PG_MAJOR}/pg_hba.conf.sample
