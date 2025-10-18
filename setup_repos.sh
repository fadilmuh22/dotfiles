#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the root directory for the setup
ROOT_DIR="$HOME"

# --- Create Directory Structure ---
echo "Creating directory structure..."
mkdir -p "$ROOT_DIR/work/nci"
mkdir -p "$ROOT_DIR/work/taspen"
mkdir -p "$ROOT_DIR/personal/emodu"
echo "Directory structure created."
echo ""

# --- Clone Repositories ---

# NCI Repositories
echo "Cloning NCI repositories..."
cd "$ROOT_DIR/work/nci"
git clone git@github.com:AGIT-Development-Center/tam-one-platform-mobile.git karsa-mobile
git clone git@github.com:Gunung-Mas-Inovasi/DOIT-MOBILE.git doit-mobile
git clone git@github.com:Gunung-Mas-Inovasi/GEMS-WEB.git gems-web
# The following repositories were in the directory structure but no git URL was provided:
# - cpa (cuan-aggregator)
# - doit-api-backoffice
# - doit-api-public
# - gems-api
echo "NCI repositories cloned."
echo ""

# Taspen Repositories
echo "Cloning Taspen repositories..."
cd "$ROOT_DIR/work/taspen"
git clone http://newrepo.taspen.co.id/tcds/authentication-service.git
git clone http://newrepo.taspen.co.id/tcds/care-service.git
git clone http://newrepo.taspen.co.id/tcds/content-service.git
git clone http://newrepo.taspen.co.id/tcds/document-repository-service.git
git clone http://newrepo.taspen.co.id/tcds/membership-service.git
git clone http://newrepo.taspen.co.id/tcds/master-data-service.git
git clone http://newrepo.taspen.co.id/tcds/notification-service.git
git clone http://newrepo.taspen.co.id/tcds/tsk-service.git
git clone http://newrepo.taspen.co.id/tcds/tsm-service.git
git clone http://newrepo.taspen.co.id/tcds/gateway.git
git clone http://newrepo.taspen.co.id/tcds/gateway-integration.git
git clone http://newrepo.taspen.co.id/nadia.ristya/andal-mobile.git
# The following repositories were in the directory structure but no git URL was provided:
# - tools
echo "Taspen repositories cloned."
echo ""

# Personal Repositories
echo "Cloning Personal repositories..."
cd "$ROOT_DIR/personal/emodu"
git clone git@github.com:HCE-RPL-UPI/DROWSINESS-DETECTION-API.git dda
git clone git@github.com:HCE-RPL-UPI/EMODU-V2-API.git emodu-v2-api
git clone git@github.com:HCE-RPL-UPI/NEW-EMODU-DASHBOARD.git emodu-dashboard
git clone git@github.com:HCE-RPL-UPI/NEW-EMODU-EXTENSIONS.git emodu-extension
echo "Personal repositories cloned."
echo ""

echo "All repositories have been cloned into their respective directories."
