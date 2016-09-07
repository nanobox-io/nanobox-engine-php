# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box     = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2048", "--ioapic", "on"]
  end

  config.vm.synced_folder ".", "/vagrant"

  # ssh keys
  config.vm.synced_folder "~/.ssh", "/var/.ssh"# , type: "nfs"

  # install docker
  config.vm.provision "shell", inline: <<-SCRIPT
    if [[ ! `which docker > /dev/null 2>&1` ]]; then
      # add docker's gpg key
      apt-key adv \
        --keyserver hkp://p80.pool.sks-keyservers.net:80 \
        --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

      # add the source to our apt sources
      echo \
        "deb https://apt.dockerproject.org/repo ubuntu-trusty main \n" \
          > /etc/apt/sources.list.d/docker.list

      # update the package index
      apt-get -y update

      # ensure the old repo is purged
      apt-get -y purge lxc-docker

      # install docker
      apt-get -y install docker-engine
    fi
  SCRIPT

  # start docker
  config.vm.provision "shell", inline: <<-SCRIPT
    if [[ ! `service docker status | grep "start/running"` ]]; then
      # start the docker daemon
      service docker start
    fi
  SCRIPT

  # wait for docker to be running
  config.vm.provision "shell", inline: <<-SCRIPT
    echo "Waiting for docker sock file"
    while [ ! -S /var/run/docker.sock ]; do
      sleep 1
    done
  SCRIPT

  # pull the build image to run tests in
  config.vm.provision "shell", inline: <<-SCRIPT
    echo "Pulling the build image"
    docker pull nanobox/build:v1
  SCRIPT

  # copy the ssh keys
  config.vm.provision "shell", inline: <<-SCRIPT
    echo "Copying SSH keys"
    mkdir -p /home/vagrant/ssh
    cp /var/.ssh/id_rsa /home/vagrant/ssh
    cp /var/.ssh/id_rsa.pub /home/vagrant/ssh
    chown -R vagrant /home/vagrant/ssh
  SCRIPT
end
