FROM gitpod/workspace-full:latest

SHELL ["/bin/bash", "-c"]

RUN sudo apt-get update \
    && sudo apt-get upgrade \
    && sudo apt-get clean \
    && sudo rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*

# That Gitpod install pyenv for me? no, thanks
WORKDIR /home/gitpod/
RUN rm .pyenv -Rf
RUN rm .gp_pyenv.d -Rf
RUN curl https://pyenv.run | bash


RUN pyenv update && pyenv install 3.12.3 && pyenv global 3.12.3
RUN pip install pipenv

# remove PIP_USER environment
USER gitpod

RUN pip3 install pytest==6.2.5 mock pytest-testdox toml
RUN npm i @learnpack/learnpack@2.1.39 -g && learnpack plugins:install @learnpack/python@1.0.3

# Install Python Dependencies
COPY ./requirements.txt /workspace/requirements.txt
RUN pip install -r /workspace/requirements.txt
