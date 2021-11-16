FROM datadog/docker-dd-agent:latest

ADD https://raw.githubusercontent.com/articulate/docker-consul-template-bootstrap/master/install.sh /tmp/consul_template_install.sh

RUN apt-get update -qq \
    && apt-get --no-install-recommends -y install wget \
    && apt-get clean \
    && cp /entrypoint.sh /dd-entrypoint.sh \
    && bash /tmp/consul_template_install.sh \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY conf.d/docker_daemon.yaml /etc/dd-agent/conf.d/docker_daemon.yaml

ENTRYPOINT ["/entrypoint.sh", "/dd-entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]
