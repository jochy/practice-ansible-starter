# Define the number of nodes
NUM_NODE = 2

# Select image from architecture
def is_arm64()
  if Vagrant::Util::Platform.windows?
    false
  else 
    `uname -m` == "arm64" || `/usr/bin/arch -64 sh -c "sysctl -in sysctl.proc_translated"`.strip() == "0"
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = if is_arm64() then "starboard/ubuntu-arm64-20.04.5" else "bento/ubuntu-22.04" end
  config.vm.box_check_update = false
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false # to use the global unsecure key instead of one insecure key per VM

  (1..NUM_NODE).each do |i|
    config.vm.define "ubu#{i}" do |node|
    
      node.vm.provider "vmware_desktop" do |vmware|
        vmware.cpus = 1
        vmware.memory = 512
        vmware.gui = true # Issue with VMware on ARM, need to have a gui
        vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
        vmware.vmx["ethernet0.pcislotnumber"] = "160"
      end

      node.vm.provider "virtualbox" do |virtualbox|
        virtualbox.cpus = 1
        virtualbox.memory = 512
      end

      node.vm.hostname = "ubu#{i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
    end
  end
end
