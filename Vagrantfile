# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "dev"
    vb.gui = true
    vb.cpus = 2
    vb.memory = "4096"

    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--bioslogofadein', 'off']
    vb.customize ['modifyvm', :id, '--bioslogofadeout', 'off']
    vb.customize ['modifyvm', :id, '--bioslogodisplaytime', '1000']
    vb.customize ["modifyvm", :id, "--usb", "on"]
  end

  config.vm.provision "file", source: "~/.ssh/known_hosts", destination: ".ssh/known_hosts"
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: ".ssh/id_rsa"
  config.vm.provision "shell", privileged:false, inline: <<-SHELL
    chmod og-rw .ssh/id_rsa
  SHELL

  #config.vm.provision :shell, privileged: false, :path => "terminal.sh"
  config.vm.provision :shell, privileged: false, :path => "graphical.sh"

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    #clone dotfiles
    #set zsh as default --test on i3 conf!!!
    #install vim plugins
    #set gtk and icon themes --test on i3 conf!!!

    sudo apt-get install -y ubuntu-desktop

    echo "[SeatDefaults]"           | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "autologin-user=vagrant"   | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "autologin-user-timeout=0" | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "user-session=i3" | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf

    sudo systemctl reboot
  SHELL

end
