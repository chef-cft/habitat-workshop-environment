# ❤ - hearts - deck 1
module "deck-1-heart-workstations" {
  source                     = "modules/workstations/"
  suit                       = "hearts"
  color                      = "${var.deck_color_1}"
  count                      = "${(var.total_workstations > 13) ? "13" : "${max(var.total_workstations,0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♦ - diamonds - deck 1
module "deck-1-diamonds-workstations" {
  source                     = "modules/workstations/"
  suit                       = "diamonds"
  color                      = "${var.deck_color_1}"
  count                      = "${(var.total_workstations > 26) ? "13" : "${max(var.total_workstations - 13, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♠ - spades - deck 1
module "deck-1-spades-workstations" {
  source                     = "modules/workstations/"
  suit                       = "spades"
  color                      = "${var.deck_color_1}"
  count                      = "${(var.total_workstations > 39) ? "13" : "${max(var.total_workstations - 26, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♣ - clubs - deck 1
module "deck-1-clubs-workstations" {
  source                     = "modules/workstations/"
  suit                       = "clubs"
  color                      = "${var.deck_color_1}"
  count                      = "${(var.total_workstations > 52) ? "13" : "${max(var.total_workstations - 39, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ❤ - hearts - deck 2
module "deck-2-heart-workstations" {
  source                     = "modules/workstations/"
  suit                       = "hearts"
  color                      = "${var.deck_color_2}"
  count                      = "${(var.total_workstations > 65) ? "13" : "${max(var.total_workstations - 52, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♦ - diamonds - deck 2
module "deck-2-diamonds-workstations" {
  source                     = "modules/workstations/"
  suit                       = "diamonds"
  color                      = "${var.deck_color_2}"
  count                      = "${(var.total_workstations > 78) ? "13" : "${max(var.total_workstations - 65, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♠ - spades - deck 2
module "deck-2-spades-workstations" {
  source                     = "modules/workstations/"
  suit                       = "spades"
  color                      = "${var.deck_color_2}"
  count                      = "${(var.total_workstations > 91) ? "13" : "${max(var.total_workstations - 78, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}

# ♣ - clubs - deck 2
module "deck-2-clubs-workstations" {
  source                     = "modules/workstations/"
  suit                       = "clubs"
  color                      = "${var.deck_color_2}"
  count                      = "${(var.total_workstations > 104) ? "13" : "${max(var.total_workstations - 91, 0)}"}"
  aws_sshkey                 = "${var.aws_sshkey}"
  contact_tag                = "${var.contact_tag}"
  workshop_prefix            = "${var.workshop_prefix}"
  workstation_ami            = "${var.workstation_ami}"
  workstation_login_password = "${var.workstation_login_password}"
  workstation_vpc            = "${module.vpc.public_subnets[0]}"
  workstation_security_group = "${module.security_group.this_security_group_id}"
}
