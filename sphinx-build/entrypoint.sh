#!/usr/bin/env bash
set -o errexit #abort if any command fails

echo 'Installing dependencies'
pip install -r requirements.txt

echo 'Building site'
make html