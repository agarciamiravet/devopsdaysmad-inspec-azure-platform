title "sample section"

control "check-storage-list" do
  azurerm_storageaccountlist.ids.each do |storageId|
    storageIdArray = storageId.split('/')
    resourcegroup =  storageIdArray[4]
    storageaccount =  storageIdArray[8]
    describe azurerm_storage_account(resource_group: resourcegroup, name: storageaccount) do
      it { should exist }
      its('properties.supportsHttpsTrafficOnly') { should be true }
    end
  end
end



control "check-vm-list" do
  azurerm_vmlist.ids.each do |vmID|
    vmIdArray = vmID.split('/')
    resourcegroup =  vmIdArray[4]
    virtualmachine =  vmIdArray[8]
    describe azurerm_virtual_machine(resource_group: resourcegroup, name: virtualmachine) do
      it { should have_monitoring_agent_installed }
      its('location') { should cmp 'westeurope' }
    end
  end
end