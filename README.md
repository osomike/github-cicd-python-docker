This repository serves as a skeleton for integrating a CI-CD for a Dockerized application which will be pushed to the Azure Container Registry.

For its use, a service principal with contributor rights will be needed on the resource groups where the container registry will be hosted.



```console
az ad sp create-for-rbac --name <my-service-principal-name> \
                         --role <role-name> \
                         --scopes </subscriptions/my-subscription-ID/resourceGroups/myResourceGroupName>
```

Store the output of the file as a secret anmed ```AZURE_CREDENTIALS``` in the repository.

The file cicd.yml from github actions folder will read its content to perform the steps.

The repository should also also contain the [Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment) ```dev```, ```acp``` and ```prd```.
