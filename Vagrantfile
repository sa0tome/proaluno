VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define :"samba_proaluno" do |host|
    
      host.vm.box = "generic/ubuntu1804"
      host.ssh.insert_key = false # important

      host.vm.network :private_network,
        :ip => "192.168.8.201",
        :libvirt__network_name => "fflch",
        :libvirt__netmask => '255.255.255.0',
        :libvirt__host_ip => "192.168.8.1",
        :libvirt__forward_mode => "nat"

      host.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
        v.default_prefix = "fflch"

      end
    end

    config.vm.define :"vm_proaluno" do |host|
      host.vm.box = "generic/debian10"
      host.ssh.insert_key = false # important

      host.vm.network :private_network,
        :ip => "192.168.8.202",
        :libvirt__network_name => "fflch",
        :libvirt__netmask => '255.255.255.0',
        :libvirt__host_ip => "192.168.8.1",
        :libvirt__forward_mode => "nat"

      host.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
        v.default_prefix = "fflch"

      end
    end

end
