FROM datadog/docker-dd-agent:latest

RUN apt-get update -qq && apt-get -y install wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /entrypoint.sh /dd-entrypoint.sh

ADD https://raw.githubusercontent.com/articulate/docker-consul-template-bootstrap/master/install.sh /tmp/consul_template_install.sh
RUN bash /tmp/consul_template_install.sh && rm /tmp/consul_template_install.sh

ENTRYPOINT ["/entrypoint.sh", "/dd-entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]
