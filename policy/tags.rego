package main

import input as plan
import data.minimum_required_tags_keys

policyID := "SEC-0001"

azurerm_resources[resources] {
	resources := plan.resource_changes[_]
}

deny[msg] {
  resource := azurerm_resources[_]
  tags := resource.change.after.tags
  resources := [sprintf("%v.%v", [resource.type, resource.name]) | not tags_contain_proper_keys(tags)]
  resources != []
	msg := sprintf("%s: Invalid tags (missing minimum required tags) for the following resource(s): `%v`. Required tags: `%v`", [policyID, resources, minimum_required_tags])
}

tags_contain_proper_keys(tags) {
	keys := {key | tags[key]}
	minimum_tags_set := {x | x := minimum_required_tags_keys[i]}
	leftover := minimum_tags_set - keys

	# If all minimum_tags exist in keys, the leftover set should be empty - equal to a new set()
	leftover == set()
}


