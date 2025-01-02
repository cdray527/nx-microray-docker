#!/bin/bash
# Check if the 'products' collection is empty
if [ "$(mongosh --quiet --eval 'db.getSiblingDB("nx-microray").products.countDocuments()')" -eq "0" ]; then
    echo "Initializing data in the 'products' collection..."
    mongoimport --host localhost --db nx-microray --collection products --file /docker-entrypoint-initdb.d/products.json --jsonArray
else
    echo "'products' collection already initialized. Skipping data import."
fi