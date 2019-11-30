FROM debian

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install certbot
RUN apt-get -y install cron

#COPY auto-renew.cron /etc/cron.d/auto-renew.cron
RUN touch /etc/cron.d/auto-renew.cron && echo '@daily certbot renew' >> /etc/cron.d/auto-renew.cron
RUN chmod 0644 /etc/cron.d/auto-renew.cron
RUN crontab /etc/cron.d/auto-renew.cron

#ENTRYPOINT ["certbot"]

EXPOSE 80 443
VOLUME /etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt
WORKDIR /opt/certbot

RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log
