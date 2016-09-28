#!/bin/bash

if [ ! -s ${HOME}/.composer ]; then
  ln -sf {{data_dir}}/var/composer ${HOME}/.composer
fi

export PATH=${HOME}/.composer/vendor/bin:$PATH
