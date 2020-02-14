title "Storage Accounts"

#StorageAccountName       ResourceGroupName              Location   SkuName        Kind      AccessTier CreationTime        ProvisioningState EnableHttpsTrafficOnly LargeFileShares
#------------------       -----------------              --------   -------        ----      ---------- ------------        ----------------- ---------------------- ---------------
#csbca00e31bed34x48f8x9b4 cloud-shell-storage-westeurope westeurope Standard_LRS   Storage              03/12/2018 12:26:10 Succeeded         True                                  
#rgalexdemoappgatewaydiag rg-alex-demo-appgateway        westeurope Standard_LRS   Storage              17/01/2020 6:18:28  Succeeded         True                                  
#rgdevopsdaysdiag         rg-devopsdays                  westeurope Standard_LRS   Storage              11/01/2020 7:04:49  Succeeded         True                   Disabled       
#stordevopsdaysmad        rg-devopsdays                  westeurope Standard_RAGRS StorageV2 Hot        11/02/2020 21:39:56 Succeeded         True                                  

#storageAccounts = { "rg-alex-demo-appgateway" => "rgalexdemoappgatewaydiag",
#"rg-devopsdays-1 " => "rgdevopsdaysdiag",
#"rg-devopsdays" => "stordevopsdaysmad "
#}
#storages = "rg-alex-demo-appgateway;rgalexdemoappgatewaydiag,rg-devopsdays;rgdevopsdaysdiag"
#storagesArray = storages.split(",")

#storages = "rg-alex-demo-appgateway;rgalexdemoappgatewaydiag,rg-devopsdays;rgdevopsdaysdiag"

storages = input('storage_account_list')

storagesArray = storages.split(",")

control "azure-array-test" do
  storagesArray.each do |test|
      storageArray2 = test.split(";")
          resourcegroup = storageArray2[0]
          storageaccount = storageArray2[1]
          describe azurerm_storage_account(name: storageaccount, resource_group: resourcegroup) do
            it { should exist }
            its('properties') { should have_attributes(supportsHttpsTrafficOnly: true) }            
          end     
  end
end