
# debian w/ python3.6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install
FROM python:3.6
# update
RUN apt-get update && apt-get -y upgrade

# env vars ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# set dockerfile var to environment
ARG app_environment=development
# set env var to dockerfile var
ENV app_environment=$app_environment

# flask application ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# add files
ADD ./app/ /app/
ADD ./instance/ /instance/
ADD ./static/ /static/

# add pip requirements
ADD ./requirements.txt /requirements.txt
# install pip requirements
RUN pip install -r /requirements.txt

# gunicorn ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# open port 80
EXPOSE 80
# move to app dir
WORKDIR /app
# run gunicorn with autoreload enabled
CMD gunicorn --reload --bind 0.0.0.0:80 $app_environment
