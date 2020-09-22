FROM postgres

RUN apt-get update && apt-get install unzip && apt-get -y install curl

RUN curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.9-linux_x86_64.bash
RUN echo "export PATH=$PATH" > .bash_profile
ENV SNOWSQL_DEST=/bin
ENV SNOWSQL_LOGIN_SHELL=.bash_profile
RUN bash snowsql-1.2.9-linux_x86_64.bash

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
