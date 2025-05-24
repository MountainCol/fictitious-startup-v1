#!/bin/bash
export SECRET_KEY='${{ secrets.SECRET_KEY }}'
export DB_USER='${{ secrets.DB_USER }}'
export DB_PASSWORD='${{ secrets.DB_PASSWORD }}'

echo "CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASSWORD}'; " | psql
