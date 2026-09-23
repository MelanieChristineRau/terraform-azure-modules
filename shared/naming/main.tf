# --------------------------------------------------
# WCC naming rules
# locals are computed values. They do not create Azure resources.
# --------------------------------------------------

locals {
  environment_aliases = {
    prd             = "prd"
    prod            = "prd"
    production      = "prd"
    pre             = "pre"
    preprod         = "pre"
    preproduction   = "pre"
    "pre-production" = "pre"
    qas             = "qas"
    qa              = "qas"
    dev             = "dev"
    development     = "dev"
    intdev          = "dev"
    preview         = "dev"
    staging         = "dev"
    sbx             = "sbx"
    sandbox         = "sbx"
  }

  # lookup(map, key, default). null default means "unknown env" and the guard fails plan.
  environment = lookup(local.environment_aliases, lower(var.environment), null)

  # Official agreed abbreviations plus proposed ones needed by v1 blocks.
  # hyphenated = official "hyphens supported" pattern.
  # stripped   = Azure rejects hyphens (storage, ACR).
  # vm         = compute pattern, no abbreviation, max 15 characters.
  catalogue = {
    subscription = { style = "hyphenated" }
    mg           = { style = "hyphenated" }
    rg           = { style = "hyphenated" }
    vnet         = { style = "hyphenated" }
    subnet       = { style = "hyphenated" }
    pl           = { style = "hyphenated" }
    pe           = { style = "hyphenated" }
    pip          = { style = "hyphenated" }
    nsg          = { style = "hyphenated" }
    alb          = { style = "hyphenated" }
    fd           = { style = "hyphenated" }
    agw          = { style = "hyphenated" }
    fw           = { style = "hyphenated" }
    ag           = { style = "hyphenated" }
    sqls         = { style = "hyphenated" }
    sql          = { style = "hyphenated" }
    adf          = { style = "hyphenated" }
    synw         = { style = "hyphenated" }
    sqlp         = { style = "hyphenated" }
    syn          = { style = "hyphenated" }
    synd         = { style = "hyphenated" }
    synsp        = { style = "hyphenated" }
    dbw          = { style = "hyphenated" }
    dec          = { style = "hyphenated" }
    sgnr         = { style = "hyphenated" }
    cosmos       = { style = "hyphenated" }
    mlw          = { style = "hyphenated" }
    srch         = { style = "hyphenated" }
    stg          = { style = "stripped" }
    dls          = { style = "stripped" }
    plan         = { style = "hyphenated" }
    app          = { style = "hyphenated" }
    func         = { style = "hyphenated" }
    aks          = { style = "hyphenated" }
    cr           = { style = "stripped" }
    appi         = { style = "hyphenated" }
    dash         = { style = "hyphenated" }
    log          = { style = "hyphenated" }
    asa          = { style = "hyphenated" }
    evhns        = { style = "hyphenated" }
    evh          = { style = "hyphenated" }
    kv           = { style = "hyphenated" }
    aa           = { style = "hyphenated" }
    vault        = { style = "hyphenated" }
    id           = { style = "hyphenated" }
    lock         = { style = "hyphenated" }
    bas          = { style = "hyphenated" }
    udr          = { style = "hyphenated" }
    logic        = { style = "hyphenated" }
    ca           = { style = "hyphenated" }
    cae          = { style = "hyphenated" }
    mysql        = { style = "hyphenated" }
    diag         = { style = "hyphenated" }
    aif          = { style = "hyphenated" }
    oai          = { style = "hyphenated" }
    di           = { style = "hyphenated" }
    budget       = { style = "hyphenated" }
    vm           = { style = "vm" }
  }

  resource_type = lower(var.resource_type)
  # try() uses hyphenated if the abbreviation is not in the catalogue yet.
  style         = try(local.catalogue[local.resource_type].style, "hyphenated")

  # compact() drops empty version_suffix. join("-") builds wcc-sbx-hack-kv01.
  hyphenated = join("-", compact([
    var.company,
    local.environment,
    var.description,
    "${local.resource_type}${var.version_suffix}"
  ]))

  # join("") with no hyphens: wccsbxhackstg01. Azure storage rejects "-".
  stripped = join("", compact([
    var.company,
    local.environment,
    var.description,
    local.resource_type,
    var.version_suffix
  ]))

  # Official compute pattern: wcc<env><description><version>, no abbreviation.
  vm = join("", compact([
    var.company,
    local.environment,
    var.description,
    var.version_suffix
  ]))

  result = local.style == "stripped" ? local.stripped : (
    local.style == "vm" ? local.vm : local.hyphenated
  )
}

# --------------------------------------------------
# Plan-time guards
# --------------------------------------------------

# terraform_data creates nothing in Azure. It only exists so we can
# attach plan-time checks (preconditions) that fail early with a clear error.
resource "terraform_data" "guards" {
  input = local.result

  lifecycle {
    precondition {
      condition     = local.environment != null
      error_message = "Unknown environment. Use prd, pre, qas, dev, sbx or a documented alias."
    }

    precondition {
      condition     = local.style != "stripped" || (length(local.result) >= 3 && length(local.result) <= 24)
      error_message = "Stripped storage or ACR names must be 3 to 24 characters."
    }

    precondition {
      condition     = local.style != "vm" || length(local.result) <= 15
      error_message = "Virtual machine names must be 15 characters or fewer."
    }
  }
}
