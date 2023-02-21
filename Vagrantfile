Vagrant.configure("2") do |config|

    config.vm.define "docker1" do |docker1|
        docker1.vm.box="shekeriev/centos-stream-9"
        docker1.vm.hostname = "host1.martin.bg"
        docker1.vm.network "private_network", ip: "192.168.34.111"
        docker1.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
        docker1.vm.synced_folder "shared/", "/vagrant", type: "virtualbox"
        docker1.vm.provision "shell", path: "setup-docker.sh"
        docker1.vm.provision "shell", path: "setup-hosts.sh"
        docker1.vm.provision "shell", path: "setup-additional-packages.sh"
        docker1.vm.provision "shell", path: "setup-firewall.sh"
        docker1.vm.provision "shell", path: "setup-manager-node.sh"
        docker1.vm.provision "shell", path: "setup-needed-files.sh"
        docker1.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "1536"]
        end
    end
	
    config.vm.define "docker2" do |docker2|
        docker2.vm.box="shekeriev/centos-stream-9"
        docker2.vm.hostname = "host2.martin.bg"
        docker2.vm.network "private_network", ip: "192.168.34.112"
        docker2.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
        docker2.vm.synced_folder "shared/", "/vagrant", type: "virtualbox"
        docker2.vm.provision "shell", path: "setup-docker.sh"
        docker2.vm.provision "shell", path: "setup-hosts.sh"
        docker2.vm.provision "shell", path: "setup-additional-packages.sh"
        docker2.vm.provision "shell", path: "setup-firewall.sh"
        docker2.vm.provision "shell", path: "setup-worker-node.sh"
        docker2.vm.provision "shell", path: "setup-needed-files.sh"
        docker2.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "1536"]
        end
    end
	
    config.vm.define "docker3" do |docker3|
        docker3.vm.box="shekeriev/centos-stream-9"
        docker3.vm.hostname = "host3.martin.bg"
        docker3.vm.network "private_network", ip: "192.168.34.113"
        docker3.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
        docker3.vm.synced_folder "shared/", "/vagrant", type: "virtualbox"
        docker3.vm.provision "shell", path: "setup-docker.sh"
        docker3.vm.provision "shell", path: "setup-hosts.sh"
        docker3.vm.provision "shell", path: "setup-additional-packages.sh"
        docker3.vm.provision "shell", path: "setup-firewall.sh"
        docker3.vm.provision "shell", path: "setup-worker-node.sh"
        docker3.vm.provision "shell", path: "setup-needed-files.sh"
        docker3.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "1536"]
        end
    end

    config.trigger.after :up do |trigger|
        trigger.only_on ="docker3"
        trigger.info = "*** Deploy stack ..."
        trigger.run = {inline: "vagrant ssh -c 'docker stack deploy -c /vagrant/docker-compose.yaml bgapp' docker1"}             
    end
    
  end
  
