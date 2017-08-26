#!/usr/bin/env bash

CMD="airflow"
chmod +x /tmp/aiflow/airflow-conf.sh
/tmp/aiflow > $AIRFLOW_HOME/airflow.cfg
exec $CMD "$@"
