# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "boxcutter/ubuntu1604"

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "2"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.synced_folder_opts = {
      owner: "_apt"
    }
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: <<-SHELL
    # There is a bug in the xenial box where the /etc/hostname value isn't in /etc/hosts
    if ! grep -q $(cat /etc/hostname) /etc/hosts; then
      sudo su -c 'echo "127.0.0.1 $(cat /etc/hostname)" >> /etc/hosts'
    fi

    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get -y dist-upgrade

    curl -fsSL https://get.docker.com/ | sh
    service docker start

    apt-get -y install git python-pip
    pip install --upgrade pip
    pip install docker-compose

    wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
    sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get update
    apt-get -y install jenkins
    usermod -aG docker jenkins
    usermod -aG docker vagrant
    service jenkins restart
  SHELL
end
