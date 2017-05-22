FROM wire/bots.runtime:latest

COPY target/roller.jar /opt/roller/roller.jar
COPY keystore.jks      /opt/roller/keystore.jks

WORKDIR /opt/roller
EXPOSE  443

