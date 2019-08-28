# From & maintainer
FROM                stakater/base:latest
MAINTAINER          Rasheed Amir <rasheed@aurorasolutions.io>

ARG                 GRAFANA_VERSION

# for installing kairosdb datasource
ENV                 GF_INSTALL_PLUGINS=grafana-kairosdb-datasource

RUN                 apt-get update && \
                    apt-get -y --no-install-recommends install libfontconfig curl wget ca-certificates && \
                    apt-get clean && \
                    wget -P /tmp/ https://dl.grafana.com/oss/release/grafana_6.3.3_amd64.deb  && \
                    dpkg -i /tmp/grafana_6.3.3_amd64.deb && \
                    rm /tmp/grafana_6.3.3_amd64.deb && \
                    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
                    chmod +x /usr/sbin/gosu && \
                    apt-get remove -y curl && \
                    apt-get autoremove -y && \
                    rm -rf /var/lib/apt/lists/*

VOLUME              ["/var/lib/grafana", "/var/lib/grafana/plugins", "/var/log/grafana", "/etc/grafana"]

EXPOSE              3000

COPY                ./run.sh /run.sh
RUN                 chmod +x /run.sh
ENTRYPOINT          ["/run.sh"]
