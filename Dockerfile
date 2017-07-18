#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

FROM debian:stretch
MAINTAINER SFox Lviv <sfox.lviv@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    PUID=${PUID:-1000} PGID=${PGID:-1000}

# create prosody user with uid and gid predefined
RUN groupadd -g $PGID -r prosody && useradd -b /var/lib -m -g $PGID -u $PUID -r -s /bin/bash prosody

ADD https://prosody.im/files/prosody-debian-packages.key /root

ADD install.sh /install.sh
RUN /install.sh
RUN rm /install.sh

ADD etc/prosody /etc/prosody
RUN chown -R prosody:prosody /etc/prosody

VOLUME ["/etc/prosody", "/var/lib/prosody", "/var/log/prosody"]

# 5000/tcp: mod_proxy65
# 5222/tcp: client to server
# 5223/tcp: deprecated, SSL client to server
# 5269/tcp: server to server
# 5280/tcp: BOSH
# 5281/tcp: Secure BOSH
# 5347/tcp: XMPP component
EXPOSE 5000 5222 5223 5269 5280 5281 5298 5347

#USER prosody

CMD ["prosody"]
