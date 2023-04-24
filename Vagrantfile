# -*- mode: ruby -*-
# vi: set ft=ruby :

goss_version="v0.3.20"
goss_url="https://github.com/goss-org/goss/releases/download/#{goss_version}/goss-linux-amd64"


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
        config.vm.provider "virtualbox" do |vb|
          vb.gui = false
          vb.memory = "2048"
        end
        # config.vm.network "forwarded_port", guest: 8443, host: 8443
        # config.vm.network "forwarded_port", guest: 3443, host: 3443
        config.vm.provision "shell", inline: <<-SHELL
          curl -s -L -k #{goss_url} -o /usr/local/bin/goss
          chmod a+x /usr/local/bin/goss
        SHELL
        config.vm.provision "ansible" do |ansible|
          #ansible.galaxy_role_file = "requirements.yml"
          ansible.galaxy_roles_path = "./roles/"
          ansible.verbose = "v"
          ansible.playbook = "test/playbook.yaml"
          # ansible.tags = [
          #   "terminal"
          # ]
          ansible.raw_arguments = [
            "--diff"
          ]
        end
        # config.vm.provision "file", source: "./tests/goss.yml", destination: "/tmp/goss.yml"

        # config.vm.provision "shell", inline: <<-SHELL
        #   goss -g /tmp/goss.yml validate --format documentation --retry-timeout 10s --sleep 1s
        # SHELL
end
