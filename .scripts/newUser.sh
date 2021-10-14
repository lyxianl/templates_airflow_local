#!/bin/bash

echo "Creating new Admin user...
=========================="

if [[ $@ ]]; then
username=$1
firstname=$1
lastname=$1
email=$2
else 
echo "Enter username: "
read username
echo "Enter firstname: "
read firstname
echo "Enter lastname: "
read lastname
echo "Enter email: "
read email
fi

password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' </dev/urandom | head -c 12)

airflow users create \
--username $username \
--firstname $firstname \
--lastname $lastname \
--email $email \
--password $password \
--role Admin

echo "==========================
User $username created successfully...
Saving credentials to .users..."

echo "username: $username
pasword: $password
firstname: $firstname
lastname: $lastname
email: $email" > .users/$username.txt
