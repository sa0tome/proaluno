VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "debian/buster64"
    config.vm.hostname = "proaluno"
    config.vm.network :private_network, ip: "10.20.30.40"
    config.ssh.insert_key = false # important

    config.vm.provider :virtualbox do |v|
      v.name = "proaluno"
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
end
