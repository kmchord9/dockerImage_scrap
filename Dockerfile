FROM python:3.7.8

ARG USERNAME=docker
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt-get update && apt-get install -y \
  libgconf-2-4 \
  xvfb \
  unzip \
  wget \
  tzdata \
  vim \
 # google chrome install
 && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
 && apt-get update \
 && apt-get install -y google-chrome-stable \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV TZ Asia/Tokyo

#google driver
RUN wget https://chromedriver.storage.googleapis.com/87.0.4280.20/chromedriver_linux64.zip \
 && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
 && chmod 755 /usr/local/bin/chromedriver

#font install
RUN wget --content-disposition http://moji.or.jp/wp-content/ipafont/IPAfont/IPAfont00303.zip \
 && unzip IPAfont00303.zip -d /usr/share/fonts/ \
 && fc-cache -fv

RUN pip install \
    selenium \
    beautifulsoup4 \
    pyvirtualdisplay \
    transitions \
    requests

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

WORKDIR /home/$USERNAME
COPY code/ .

CMD ["bash"]
