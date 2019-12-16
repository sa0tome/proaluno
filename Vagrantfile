VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "dc" do |host|
    host.vm.box = "debian/buster64"
    host.vm.network :private_network, ip: "10.20.0.2"
    config.ssh.insert_key = false # important

    host.vm.provider :virtualbox do |v|
      v.name = "dc"
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--groups", "/proaluno"]
    end
  end

  config.vm.define "proaluno1" do |host| 
    host.vm.box = "debian/buster64"
    host.vm.network :private_network, ip: "10.20.0.3"
    config.ssh.insert_key = false # important

    host.vm.provider :virtualbox do |v|
      v.name = "proaluno1"
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--groups", "/proaluno"]
    end
  end

end
