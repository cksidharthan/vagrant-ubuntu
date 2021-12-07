# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
# Box / OS
VAGRANT_BOX = 'ubuntu/focal64'
# Memorable name for your
VM_NAME = 'ubuntu'
# VM User — 'vagrant' by default
VM_USER = 'vagrant'
# Username on your Mac
USER = 'cksid'
# Host folder to sync
HOST_PATH = '/Users/' + USER
# Where to sync to on Guest — 'vagrant' is the default user name
GUEST_PATH = '/home/' + VM_USER + '/' + VM_NAME
# # VM Port — uncomment this to use NAT instead of DHCP
VM_PORT = 8080
Vagrant.configure(2) do |config|
  # Vagrant box from Hashicorp
  config.vm.box = VAGRANT_BOX
  config.vm.box_version = "20211021.0.0"
  config.vm.boot_timeout = 600
  config.vm.hostname = "ubuntu"


  # copy required files
  config.vm.provision "file", source: "/Users/" + USER + "/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
  config.vm.provision "file", source: "/Users/" + USER + "/.ssh/id_rsa", destination: "~/.ssh/id_rsa"

  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chmod 644 /home/vagrant/.ssh/.id_rsa.pub
    chmod 600 /home/vagrant/.ssh/id_rsa
  SHELL

  # Sync folder
  config.vm.synced_folder HOST_PATH, GUEST_PATH
  # Disable default Vagrant folder, use a unique path per project
  config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
  config.vm.synced_folder '.', '/home/'+USER

  config.vm.define "devenv" do |devenv|
    devenv.vm.box = "ubuntu/focal64"
    devenv.vm.box_version = "20210603.0.0"
    devenv.vm.boot_timeout = 600
    devenv.vm.hostname = 'devenv'

    devenv.vm.provision "shell", path: "./devenv_customization.sh"
    devenv.vm.network :private_network, ip: "192.168.56.3"
    devenv.vm.network "forwarded_port", guest: 443, host: 443
    devenv.vm.network "forwarded_port", guest: 80, host: 80

    devenv.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = "4096"
      v.cpus = "2"
    end
  end
end