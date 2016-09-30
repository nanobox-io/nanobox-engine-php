#!/bin/bash

if [ ! -s ${HOME}/.composer ]; then
  ln -sf {{code_dir}}/.composer ${HOME}/.composer
fi

export PATH=${HOME}/.composer/vendor/bin:$PATH
