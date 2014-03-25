# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/fedora-19"
  config.omnibus.chef_version = :latest
  
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["./chef-repo/cookbooks","./chef-repo/site-cookbooks"]
    chef.add_recipe "base"
    chef.json = {}
  end

end
