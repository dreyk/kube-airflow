#!/usr/bin/env bash

CMD="airflow"
cp /tmp/aiflow/airflow-conf.sh $AIRFLOW_HOME/airflow-conf.sh
chmod +x $AIRFLOW_HOME/airflow-conf.sh
/tmp/aiflow/airflow-conf.sh > $AIRFLOW_HOME/airflow.cfg
exec $CMD "$@"
