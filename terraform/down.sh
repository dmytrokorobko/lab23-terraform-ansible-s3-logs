#!/bin/bash
set -e
terraform -chdir=./02_compute destroy
terraform -chdir=./01_network destroy