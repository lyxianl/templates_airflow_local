# Initialize Local Airflow

**Procedure**

- Clean workspace
- Initialize virtualenv
- Create folders and .env
- Install packages in virtualenv
- Export variables for future sessions
- Initialize Airflow DB
- Create admin user for Airflow
- Create sample DAG

## Notes

**Warnings**

- pip install :
  - ERROR: flask 1.1.4 has requirement itsdangerous<2.0,>=0.24, but you'll have itsdangerous 2.0.1 which is incompatible.
  - ERROR: jinja2 3.0.2 has requirement MarkupSafe>=2.0, but you'll have markupsafe 1.1.1 which is incompatible.
  - ERROR: flask 1.1.4 has requirement click<8.0,>=5.1, but you'll have click 8.0.3 which is incompatible.
  - ERROR: flask 1.1.4 has requirement Jinja2<3.0,>=2.10.1, but you'll have jinja2 3.0.2 which is incompatible.
  - ERROR: flask-appbuilder 3.3.4 has requirement SQLAlchemy<1.4.0, but you'll have sqlalchemy 1.4.25 which is incompatible.
