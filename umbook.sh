#!/bin/bash

mongoimport --db UMbook --collection conversas --file /povoamento/conversas.json --jsonArray && \
mongoimport --db UMbook --collection mensagens --file /povoamento/mensagens.json --jsonArray