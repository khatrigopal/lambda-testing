# lambda_functions/main.tf
variable "functions" {
  type = list(object({
    name            = string
    handler         = string
    runtime         = string
   # source_code_hash = string
    role = string
  }))
}

resource "aws_lambda_function" "lambda_functions" {
  for_each = { for f in var.functions : f.name => f }

  function_name    = each.value.name
  handler          = each.value.handler
  runtime          = each.value.runtime
 # source_code_hash = each.value.source_code_hash

  filename         = each.value.name
  role = each.value.role

  #source_code_hash = each.value.source_code_hash

  #source_code_size = data.archive_file[each.value.name].output_size

  # Add any other necessary configuration here
}
