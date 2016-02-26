#!/usr/bin/env bash

HDP_VERSION=$1
HDP_UTILS_VERSION=$2
AMBARI_VERSION=$3

MIRROR_DIR=/usr/local/apache2/htdocs/mirrors
mkdir -p ${MIRROR_DIR}

# FQDN comes from the docker environment

yum-config-manager --add-repo http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/${AMBARI_VERSION}/ambari.repo
cd ${MIRROR_DIR}
mkdir -p ambari/centos7
cd ambari/centos7
reposync -r Updates-ambari-${AMBARI_VERSION}

yum-config-manager --add-repo http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/${HDP_VERSION}/hdp.repo
cd ${MIRROR_DIR}
mkdir -p hdp/centos7
cd hdp/centos7
reposync -r HDP-${HDP_VERSION}
reposync -r HDP-UTILS-${HDP_UTILS_VERSION}

cd ${MIRROR_DIR}
createrepo .

