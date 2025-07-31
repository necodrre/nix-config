{
  # Install docker
  virtualisation.docker.enable = true;

  # Set rootless docker mode
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Install and configure VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;  # Install Oracle VirtualBox Extensions.
                                                              # Unfree software permission is required.
  users.extraGroups.vboxusers.members = [ "rat" ];
  virtualisation.virtualbox.host.enableKvm = true;             # Enables KVM threading
  virtualisation.virtualbox.host.addNetworkInterface = false;  # Because VirtualBox KVM only supports standard NAT networking for VMs
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];         # Fix the KVM issue
}
