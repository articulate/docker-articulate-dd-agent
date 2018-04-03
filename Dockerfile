FROM datadog/docker-dd-agent:latest-alpine

RUN apk --no-cache update && apk upgrade && apk add bash curl wget && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp /entrypoint.sh /dd-entrypoint.sh

ADD https://raw.githubusercontent.com/articulate/docker-consul-template-bootstrap/master/install.sh /tmp/consul_template_install.sh
RUN bash /tmp/consul_template_install.sh && rm /tmp/consul_template_install.sh

COPY conf.d/docker_daemon.yaml /opt/datadog-agent/agent/conf.d/docker_daemon.yaml

ENTRYPOINT ["/entrypoint.sh", "/dd-entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/opt/datadog-agent/agent/supervisor.conf"]