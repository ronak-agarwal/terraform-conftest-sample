```hcl
terraform init
terraform plan -refresh=false -no-color -out=tfplan
terraform show -no-color -json tfplan | jq > plan.json
 conftest test --data data/ plan.json
```