title 'Check blob storage settings'

control "azure-blobstorage-check-settings" do
    title 'Check security settings of blob storage'
    azurerm_storageaccountlist.ids.each do |storageId|
      storageIdArray = storageId.split('/')
      resourcegroup =  storageIdArray[4]
      storageaccount =  storageIdArray[8]      
      describe azurerm_storage_account(resource_group: resourcegroup, name: storageaccount) do
        it { should exist }
        its('properties') { should have_attributes(supportsHttpsTrafficOnly: true) }    
      end
    end
end