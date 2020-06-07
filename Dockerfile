# pivot-docker - Community-developed Docker container for PIVOT transcriptomics
# Copyright (C) 2019-2020  Emir Turkes
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

FROM rocker/verse:3.6.3

LABEL maintainer="Emir Turkes emir.turkes@eturkes.com"

COPY etc /usr/local/lib/R/etc/

RUN echo "echo 'PIVOT is ready, please visit localhost in your web browser. When you are finished, enter Ctrl+C in this terminal to close PIVOT.'" \
        > /usr/bin/xdg-open \
    && chmod +x /usr/bin/xdg-open \
    && R -f /usr/local/lib/R/etc/install.R \
    && rm -Rf /tmp/downloaded_packages/ \
        /tmp/*.rds

CMD ["R", "-f", "/usr/local/lib/R/etc/start.R"]
