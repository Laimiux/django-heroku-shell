#!/bin/bash

#Take project name as input
if [ -z "$1" ]
then
    echo "Enter project name"
    read proj
else
    proj="$1"
fi


# Create a project folder
mkdir $proj
cd $proj

# Create a virtualenv
virtualenv venv --distribute
source venv/bin/activate

echo "PIP_RESPECT_VIRTUALENV=true" >> source/bin/activate

# Install all needed packages for Heroku
pip install Django
pip install dj-database-url
pip install dj-static
pip install gunicorn
pip install psycopg2
pip install static
pip install django-toolbelt

pip freeze > requirements.txt
#Create django project
django-admin.py startproject $proj .

echo "web: gunicorn $proj.wsgi">Procfile

#Set default environment variables
#export DJANGO_SETTINGS_MODULE="$proj.settings"
#export PYTHONPATH="$VIRTUAL_ENV/$proj"

#Write the variables into activate for future use.
#echo "export DJANGO_SETTINGS_MODULE=$proj.settings" >> source/bin/activate
#echo "export PYTHONPATH=$VIRTUAL_ENV/$proj" >> source/bin/activate


echo "Continue from here: https://devcenter.heroku.com/articles/getting-started-with-django#django-settings"

# Reset virtualenv and we are ready
deactivate
#source venv/bin/activate target/start -Dhttp.port=5432  -DapplyEvolutions.default=true -Ddb.default.driver=org.postgresql.Driver -Ddb.default.url=





