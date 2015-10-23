FROM ubuntu:14.04
MAINTAINER saberlion <admin@saberlion.info>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install nginx python-pip python-dev supervisor

RUN mkdir -p /var/log/nginx/app
RUN mkdir -p /var/log/uwsgi/app/


RUN rm /etc/nginx/sites-enabled/default
COPY webssh_nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/webssh_nginx.conf /etc/nginx/sites-enabled/webssh_nginx.conf


RUN echo "daemon off;" >> /etc/nginx/nginx.conf


RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY app /var/www/app

RUN pip install -r /var/www/app/requirements.txt

EXPOSE 80
CMD ["/usr/bin/supervisord"]