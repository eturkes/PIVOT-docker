# PIVOT-docker - Docker container for the PIVOT transcriptomics platform
# Copyright (C) 2019  Emir Turkes
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

FROM rocker/shiny:3.5.3

LABEL maintainer="Emir Turkes eturkes@bu.edu"

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

COPY install.R /tmp/

RUN wget "https://travis-bin.yihui.name/texlive-local.deb" \
    && dpkg -i texlive-local.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        default-jdk \
        fonts-roboto \
        ghostscript \
        libbz2-dev \
        libicu-dev \
        liblzma-dev \
        libhunspell-dev \
        libmagick++-dev \
        librdf0-dev \
        libv8-dev \
        qpdf \
        texinfo \
        libzmq3-dev \
        libopenmpi-dev \
        libssl-dev \
    && install2.r --error tinytex \
    && wget -qO- \
        "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
        sh -s - --admin --no-path \
    && mv ~/.TinyTeX /opt/TinyTeX \
    && /opt/TinyTeX/bin/*/tlmgr path add \
    && tlmgr install metafont mfware inconsolata tex ae parskip listings \
    && tlmgr path add \
    && Rscript -e "tinytex::r_texmf()" \
    && chown -R root:staff /opt/TinyTeX \
    && chown -R root:staff /usr/local/lib/R/site-library \
    && chmod -R g+w /opt/TinyTeX \
    && chmod -R g+wx /opt/TinyTeX/bin \
    && echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron \
    && install2.r --error PKI \
    && install2.r --error --deps TRUE \
        bookdown rticles rmdshower rJava \
    && R -f /tmp/install.R \
    && apt-get clean \
    && rm -Rf /var/lib/apt/lists/ \
        /tmp/downloaded_packages/ \
        /tmp/*.rds \
        /tmp/install.R \
        texlive-local.deb \
        /srv/shiny-server/*

COPY shiny-server.conf  /etc/shiny-server/
COPY shiny-server.sh /usr/bin/
COPY PIVOT/inst/app/ /srv/shiny-server/

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
