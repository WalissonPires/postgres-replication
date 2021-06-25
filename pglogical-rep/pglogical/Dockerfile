ARG PG_MAJOR=10

FROM postgres:${PG_MAJOR}

# Build utils
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget python-pip curl build-essential

# PG-Logical
RUN \
  echo "deb [arch=amd64] http://packages.2ndquadrant.com/pglogical/apt/ jessie-2ndquadrant main\n" \
    > /etc/apt/sources.list.d/2ndquadrant.list

RUN wget --quiet -O - http://packages.2ndquadrant.com/pglogical/apt/AA7A6805.asc | apt-key add - && apt-get update

RUN apt-get install -y --no-install-recommends postgresql-server-dev-${PG_MAJOR} libpq-dev

RUN apt-get install -y --no-install-recommends \
  postgresql-${PG_MAJOR}-pglogical

# Cleanup
RUN apt-get update -y -qq --fix-missing \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


# Configuration
#COPY config/postgresql.conf "/usr/share/postgresql/${PG_MAJOR}/postgresql.conf.sample"
#COPY config/pg_hba.conf "/usr/share/postgresql/${PG_MAJOR}/pg_hba.conf"