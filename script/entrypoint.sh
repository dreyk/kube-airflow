#!/usr/bin/env bash

CMD="airflow"
chmod +x $AIRFLOW_HOME/confgen/airflow-conf.sh
$AIRFLOW_HOME/confgen/airflow-conf.sh > $AIRFLOW_HOME/airflow.cfg
exec $CMD "$@"
