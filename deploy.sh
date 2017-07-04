#!/bin/bash
set -e

source deployment.conf

WIRE_BOT_CONFIG_FILE="conf/roller.yaml"
WIRE_FILES_TO_TRANSFER=("target/roller.jar" "conf/roller.yaml" "keystore.jks" "start.sh")
WIRE_TAR="deployment.tgz"

echo ">>>>> CREATE TARBALL"
tar -cvzf ${WIRE_TAR} ${WIRE_FILES_TO_TRANSFER[@]}

echo ">>>>> COPY OVER"
scp -i ${WIRE_IDENTITY_FILE} ${WIRE_TAR} ${WIRE_REMOTE_HOST}:${WIRE_REMOTE_FOLDER}

echo ">>>>> REMOTE UNTAR"
ssh -i ${WIRE_IDENTITY_FILE} ${WIRE_REMOTE_HOST} "cd ${WIRE_REMOTE_FOLDER}; tar xvzf ${WIRE_TAR}; rm ${WIRE_TAR}"
ssh -i ${WIRE_IDENTITY_FILE} ${WIRE_REMOTE_HOST} "cd ${WIRE_REMOTE_FOLDER}; sed -i -e s/%token%/${WIRE_BOT_TOKEN}/  ${WIRE_BOT_CONFIG_FILE}"

echo ">>>>> CLEAN UP"
rm ${WIRE_TAR}