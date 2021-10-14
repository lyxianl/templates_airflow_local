#!/bin/bash

# Constants
username=lyx
email=lyxlyxi@hotmail.com
port=8080

### Clean-up Workspace
ls -a | grep -v '\.scripts\|README.md\|\.$' | xargs rm -rf

### Initialize Virtualenv
python3 -m venv .venv
echo "~: Virtualenv created"

### Create Files/Folders 
mkdir $PWD/dags
mkdir $PWD/.users
echo "~: Directories created"

### Store variables in .env
echo "AIRFLOW_HOME=$PWD/airflow
AIRFLOW__LOGGING__BASE_LOG_FOLDER=$PWD/logs
AIRFLOW__CORE__DAGS_FOLDER=$PWD/dags
AIRFLOW__CORE__LOAD_EXAMPLES=False
AIRFLOW__CORE__FERNET_KEY=$(openssl rand -base64 32)
AIRFLOW__API__AUTH_BACKEND=airflow.api.auth.backend.basic_auth" > .env

### Install Packages
source $PWD/.venv/bin/activate
pip install wheel apache-airflow==2.2.0 psycopg2-binary
echo "~: Packages installed"

### Export variables for future sessions
echo "
set -a
source $PWD/.env
set +a" >> $PWD/.venv/bin/activate

### Create Database
airflow db init
echo "~: DB initialized"

### Create Users (from script)
bash $PWD/.scripts/newUser.sh $username $email

### Create Testing DAG
echo """from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2021, 1, 1),
    'schedule_interval': '@daily',
    'catchup': False,
}

dag = DAG(
    dag_id='Sample_DAG',
    default_args=default_args
)

t1 = BashOperator(
    task_id='print_date',
    bash_command='date',
    dag=dag
)

t1""" > dag/sample.py

### Start Airflow
airflow webserver --port $port --daemon & airflow scheduler