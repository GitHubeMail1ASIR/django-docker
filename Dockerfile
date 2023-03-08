FROM python:3
LABEL githubemail1asir "githubemail1asir@gmail.com"
WORKDIR /usr/src/app
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && git clone https://github.com/GitHubeMail1ASIR/django-docker.git /usr/src/app && mkdir static && apt clean && rm -rf /var/lib/apt/lists/*
#ADD conf.sh /usr/src/app/
RUN chmod +x /usr/src/app/config.sh
ENV ALLOWED_HOSTS=*
ENV DJANGODB_HOST=mariadb_django
ENV DJANGODB_USER=django
ENV DJANGODB_PASS=django
ENV DJANGODB=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@gmail.com
ENTRYPOINT ["/usr/src/app/conf.sh"]
