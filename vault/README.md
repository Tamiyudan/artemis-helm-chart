### This directory is used to create vault secrets


# Usage: 
#### 0. Run 
```
export VAULT_TOKEN="YOUR_TOKEN_HERE"
```

#### 1. Configure backend and Initialize terraform 
```
source ../setenv.sh
```
#### 2. Create 
```
terraform apply    -var-file ../configurations.tfvars 
```



