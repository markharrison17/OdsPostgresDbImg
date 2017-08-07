#!/bin/sh

docker run -p 5432:5432 -d -v /mnt/git/ods/ImportTool:/usr/src/ImportTool -v /mnt/git/ods/data/:/usr/src/ImportTool/data ods-postgres-db-img

#RUN IN CONTAINER:
#psql -U postgres -c "CREATE DATABASE openods OWNER postgres;"
#cd /usr/src/ImportTool
#python3 import.py -d postgres -l -c postgresql://postgres@localhost/openods --verbose
