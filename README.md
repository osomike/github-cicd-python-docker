This repository serves as a skeleton for integrating a CI-CD for a Dockerized application which will be pushed to the Azure Container Registry.

For its use, a resource group, a container registry and a service principal with contributor or owner rights will be needed.

To create the service principal you can execute:

```console
az ad sp create-for-rbac --name <my-service-principal-name> \
                         --role <role-name> \
                         --scopes </subscriptions/my-subscription-ID/resourceGroups/myResourceGroupName> \
                         --sdk-auth
```

The scope of the service principal can be extended to the subscription, just use ```--scopes </subscriptions/my-subscription-ID``` instead.

The output of the previous command should look like this:
```console
{
  "clientId": "<cliend-ID>",
  "clientSecret": "<cliend-secret>",
  "subscriptionId": "<subscription-ID>",
  "tenantId": "<tenant-ID>",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

Store this output as a secret named ```AZURE_CREDENTIALS``` in the repository.

To create the resource group and the container registry, use the terraform files on the ```infrastructure``` folder.

For it, execute:
```console
cd infrastructure
terraform init
terraform apply
```

Once your test are done, you can get rid of the infrastructure by calling
```console
terraform destroy
```

The file ```cicd.yml``` from github workflows folder will read its content to perform the steps.

The repository can also contain the [Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment) ```dev```, ```acp``` and ```prd```.
