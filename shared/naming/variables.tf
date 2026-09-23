# Variables are inputs. The calling module sets them.
# validation {} rejects bad values at plan time, before Azure is touched.

variable "company" {
  type        = string
  default     = "wcc"
  description = "Organisation prefix from the WCC naming standard."

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{1,6}$", var.company))
    error_message = "company must be lowercase alphanumeric and start with a letter."
  }
}

variable "environment" {
  type        = string
  description = "WCC environment designation or alias: prd, pre, qas, dev, sbx (or prod, preprod, qa, sandbox, staging, preview, intdev)."
}

variable "description" {
  type        = string
  description = "Short lowercase workload or application name. Example: hack, drupal, web."

  validation {
    condition     = can(regex("^[a-z0-9]{1,20}$", var.description))
    error_message = "description must be 1 to 20 lowercase alphanumeric characters."
  }
}

variable "resource_type" {
  type        = string
  description = "Official or proposed WCC resource abbreviation. Example: rg, kv, stg, srch, aif. Use 'vm' for virtual machines."
}

variable "version_suffix" {
  type        = string
  default     = ""
  description = "Optional version or instance suffix from the standard. Example: 01. Leave empty when unused."

  validation {
    condition     = var.version_suffix == "" || can(regex("^[a-z0-9]{1,6}$", var.version_suffix))
    error_message = "version_suffix must be empty or 1 to 6 lowercase alphanumeric characters."
  }
}
