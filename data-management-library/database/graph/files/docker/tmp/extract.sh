#!/bin/bash

unzip oracle-graph-zeppelin-interpreter-20.1.0.zip -d ./oracle-graph-zeppelin-interpreter
cp ./oracle-graph-zeppelin-interpreter/*.jar ../zeppelin/interpreter/pgx/
rm -r ./oracle-graph-zeppelin-interpreter

unzip apache-groovy-binary-2.4.18.zip
cp ./groovy-2.4.18/lib/*.jar ../zeppelin/interpreter/pgx/
rm -r ./groovy-2.4.18
