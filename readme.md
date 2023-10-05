terraform init
terraform plan -refresh=false -no-color -out=tfplan_2_resources_planned
terraform show -no-color -json tfplan_2_resources_planned | jq > plan.json
conftest test --data .\data\ .\plan.json