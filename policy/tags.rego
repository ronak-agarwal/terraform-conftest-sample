package main

import data.minimum_required_tags_keys
import input as plan

policyID := "SEC-0001"
env := "dev|test|staging|prod"

azurerm_resources[resources] {
	resources := plan.resource_changes[_]
}

deny[msg] {
	resource := azurerm_resources[_]
	tags := resource.change.after.tags
	resources := [sprintf("%v.%v", [resource.type, resource.name]) | not tags_contain_proper_keys(tags)]
	resources != []
	msg := sprintf("%s: Invalid tags (missing minimum required tags keys) for the following resource(s): `%v`. Required tags: `%v`", [policyID, resources, minimum_required_tags_keys])
}

deny[msg] {
	resource := azurerm_resources[_]
	tags := resource.change.after.tags
	not tags_value_invalid(tags)
	msg := sprintf("%s: Invalid tags values for the following Resource Name: `%v` and Tags: `%v`", [policyID, resource.name, tags])
}


tags_contain_proper_keys(tags) {
	keys := {key | tags[key]}
	minimum_tags_set := {x | x := minimum_required_tags_keys[i]}
	leftover := minimum_tags_set - keys

	# If all minimum_tags exist in keys, the leftover set should be empty - equal to a new set()
	leftover == set()
}

tags_value_invalid(tags) {
	re_match(env, tags.environment)
}