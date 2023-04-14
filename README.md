### This repo is used to deploy artemis


### 1. Configure backend and Initialize terraform: 
```
source setenv.sh
```

#### 2. Create 
```
terraform apply -var-file configurations.tfvars -auto-approve
```
