locals {
  base = "${var.project}-${var.environment}-${var.region_short}-${var.instance}"

  # ACR names: alphanumeric, lowercase, no dashes, max 24 chars
  base_alphanum = lower(replace(local.base, "-", ""))
  acr_name      = substr("acr${local.base_alphanum}", 0, 24)

  tags = {
    project      = var.project
    environment  = var.environment
    managed_by   = "terraform"
    keep         = "false"
    keep_until   = var.keep_until
    owner        = var.owner
    cost_center  = "learning"
    created_date = timestamp()
  }
}
