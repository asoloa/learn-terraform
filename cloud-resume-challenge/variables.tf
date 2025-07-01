variable "access_key" {
    description = "AWS Access Key ID [currently stored as env variable]"
    type = string
    sensitive = true
}

variable "secret_key" {
    description = "AWS Access Secret Key [currently stored as env variable]"
    type = string
    sensitive = true
}