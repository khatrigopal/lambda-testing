variable "functions" {
  type = list(object({
    name            = string
    handler         = string
    runtime         = string
    #source_code_hash = string
    role = string
  }))
}
