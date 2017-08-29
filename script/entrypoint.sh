#!/usr/bin/env bash

CMD="airflow"

/bin/bash $AIRFLOW_HOME/confgen/airflow-conf.sh > $AIRFLOW_HOME/airflow.cfg

cat $AIRFLOW_HOME/airflow.cfg

exit 1

exec $CMD "$@"
