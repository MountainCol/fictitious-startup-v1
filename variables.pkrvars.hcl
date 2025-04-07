# subnet_id variable
variable "subnet_id" {
    type        = string
    default     = "subnet-07bb9d35c843a68de"
    description = "public subnet"
    sensitive   = true
    # When a variable is sensitive all string-values from that variable will be
    # obfuscated from Packer's output.
}

# vpc_id variable
variable "vpc_id" {
    type        = string
    default     = "vpc-03e7c706057f8d375"
    description = "description of the vpc_id variable"
    sensitive   = true
}

# version variable
variable "version" {
    type        = string
    default     = "cloudtalents-startup-v1.0.0"
    description = "version required variable"
    sensitive   = false
    # When a variable is sensitive all string-values from that variable will be
    # obfuscated from Packer's output.
}
