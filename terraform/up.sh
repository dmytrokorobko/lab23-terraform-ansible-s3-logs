#!/bin/bash
set -e
terraform -chdir=./01_network apply
terraform -chdir=./02_compute apply