$script = <<SCRIPT
    locale-gen en_GB.UTF-8
    apt-get --assume-yes update
    apt-get --assume-yes dist-upgrade
    apt-get --assume-yes install git curl

    wget -qO- https://raw.githubusercontent.com/vantage-org/vantage/back-to-bash/bootstrap | sh

    curl -sSL https://get.docker.com/ | sh
    usermod -aG docker vagrant

    ln -s /vagrant /usr/local/vantage/plugins/installed/redis
SCRIPT

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.provision "shell", inline: $script
end
