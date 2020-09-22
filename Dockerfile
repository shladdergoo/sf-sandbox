FROM postgres:13

RUN apt-get update && apt-get install unzip && apt-get -y install curl

RUN curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.9-linux_x86_64.bash
RUN echo "export PATH=$PATH" > .bash_profile
ENV SNOWSQL_DEST=/bin
ENV SNOWSQL_LOGIN_SHELL=.bash_profile
RUN bash snowsql-1.2.9-linux_x86_64.bash

ARG SF_ACCOUNT
ARG SF_PWD
ARG SF_UNAME
ENV SNOWSQL_ACCOUNT=$SF_ACCOUNT
ENV SNOWSQL_USER=$SF_UNAME
ENV SNOWSQL_DATABASE=ADW
ENV SNOWSQL_SCHEMA=ADW_PL
ENV SNOWSQL_PWD=$SF_PWD

RUN snowsql -q "select get_ddl('table', 'CUSTOMER_DIM');" -o output_format=plain -o header=false -o timing=false -o friendly=false | sed -E 's/or replace //' > /docker-entrypoint-initdb.d/01_customer-dim.sql
