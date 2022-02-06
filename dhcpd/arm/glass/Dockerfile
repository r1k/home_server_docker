FROM balenalib/armv7hf-ubuntu-node

RUN apt-get update && apt-get -y --no-install-recommends install git dhcpd-pools 

RUN git clone https://github.com/Akkadius/glass-isc-dhcp.git /opt/glass  

WORKDIR /opt/glass  

RUN rm bin/dhcpd-pools && mkdir logs && chmod u+x ./bin/ -R && chmod u+x *.sh && npm install

RUN ln -s `which dhcpd-pools` bin/dhcpd-pools

VOLUME /var/lib/dhcp/dhcpd.lease /var/log/dhcp.log /etc/dhcp/dhcpd.conf /opt/glass/config  

EXPOSE 3000
EXPOSE 8081

ENTRYPOINT ["npm", "start"]
