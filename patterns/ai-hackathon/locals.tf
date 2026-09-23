# local.rag is true only when mode = "rag".
# Resources use count = local.rag ? 1 : 0 so RAG extras are skipped in minimum mode.

locals {
  rag = var.mode == "rag"
}
