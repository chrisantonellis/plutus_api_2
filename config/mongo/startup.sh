
echo "~~~~~ Startup Script STARTED"

# load environment management functions
echo "~~~~~ Loading environment management functions"
. /instance/environment.sh

# setup environment
echo "~~~~~ Calling environment_setup()"
environment_setup

# start mongod
echo "~~~~~ Starting mongod"
mongod --quiet &

# wait for mongo to startup
echo "~~~~~ Waiting for mongo to start"
sleep 3

# create admin user in admin db
echo "~~~~~ Creating ADMIN user"
mongo $MONGO_AUTHENTICATION_DATABASE --eval 'db.createUser({
  "user": "'$MONGO_ADMIN_USERNAME'",
  "pwd": "'$MONGO_ADMIN_PASSWORD'",
  "roles": [{
    "role": "userAdminAnyDatabase",
    "db": "admin"
  }]
})'

# create database user
echo "~~~~~ Creating USER user"
mongo admin --eval 'db.auth({
  "user": "'$MONGO_USER_USERNAME'",
  "pwd": "'$MONGO_USER_PASSWORD'",
  "roles": {{
    "role": "readWrite",
    "db": "'$MONGO_USER_DATABASE'"
  }}
})'

# teardown environment
echo "~~~~~ Calling environment_teardown()"
environment_teardown()

# stop mongod
echo "~~~~~ Stopping mongod"
mongo admin --eval 'db.shutdownServer()'

# wait for mongo to shutdown
echo "~~~~~ Waiting for mongod to shutdown"
sleep 3

# start mongod with auth enabled
echo "~~~~~ Restarting mongod with config file and auth enabled!"
mongod --config /etc/mongod.conf
