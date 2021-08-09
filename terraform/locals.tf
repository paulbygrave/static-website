resource "random_pet" "id" {
  length = 2
}

locals {
  name = random_pet.id
}