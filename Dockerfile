# MIT License

# Copyright (c) 2022 Eros Fabrici eros.fabrici@gmail.com

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM ubuntu

LABEL base.image="ubuntu"
LABEL version="1"
LABEL software="MultiQC"
LABEL software.version="1.9"
LABEL description="Aggregate bioinformatics results across many samples into a single report."
LABEL website="https://github.com/ewels/MultiQC"
LABEL license="https://github.com/eferos93/multiqc-docker-image/blob/main/LICENSE"
LABEL maintainer="Eros Fabrici"
LABEL maintainer.email="eros.fabrici@gmail.com"

RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository universe
RUN apt-get update && apt-get install -y \
    wget \
    python3 \
    python3-dev \
    python3-pip \
    texlive-xetex \
    texlive-science \
    locales && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN pip3 install "multiqc==1.9"

RUN wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz && \
    tar -xvf pandoc-2.7.3-linux.tar.gz && \
    rm pandoc-2.7.3-linux.tar.gz

ENV LC_ALL='C.UTF-8' LANG='C.UTF-8'

ENV PATH="/pandoc-2.7.3/bin:${PATH}"

RUN mkdir genomic_data

ENTRYPOINT ["multiqc"]
