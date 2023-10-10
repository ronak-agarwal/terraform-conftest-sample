variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "location" {
    type = string
    description = "allowed region"
    validation {
      condition = can(regex("us[0-9]?$",var.location))
      error_message = "Only US region allowed"
    }
}
