FROM ubuntu:trusty

MAINTAINER Christian Rondeau

RUN apt-get -y update && apt-get install -y git grep vim
RUN git clone https://github.com/junegunn/vader.vim.git

COPY . vimcastle/

CMD vim --version | grep -E '(patch|IMproved)'
CMD vim -Nu vimcastle/tests/vimrc -c 'Vader! vimcastle/tests/**'
