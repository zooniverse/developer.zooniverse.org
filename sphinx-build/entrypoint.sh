#!/bin/sh
set -o errexit #abort if any command fails

echo 'Installing dependencies'
pip install -r requirements.txt

echo 'Building site'
make html

touch _build/html/.nojekyll