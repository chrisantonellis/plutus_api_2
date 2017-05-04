
# debian w/ mongo3.4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install
FROM mongo:3.4
# update
RUN apt-get update && apt-get -y upgrade

# mongo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# open port 27017
EXPOSE 27017

# add mongo config file
ADD ./config/mongo/mongod.conf /etc/mongod.conf

# add environment setup script
ADD ./instance/mongo/environment.sh /instance/environment.sh

# add startup script
ADD ./config/mongo/startup.sh /config/startup.sh
RUN chmod +x /config/startup.sh

# run startup script
CMD /config/startup.sh
