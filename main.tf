# main.tf##
provider "aws" {
  region = "us-east-1"
}

data "archive_file" "function1" {
  type        = "zip"
  source_dir  = "function1"
  output_path = "/tmp/function1.zip"
}



data "archive_file" "function2_archive" {
  type        = "zip"
  source_dir  = "function2"
  output_path = "function2.zip"
}

module "lambda_functions" {
  source = "./lambda_functions"

  functions = [
    {
      name            = "function1"
      handler         = "function1.lambda_handler"
      runtime         = "python3.8"
      filename       = data.archive_file.function1.output_path
      #source_code_hash = filebase64sha256("${data.archive_file.function1.output_path}")
      source_code_hash = data.archive_file.function1.output_base64sha256
      role = "arn:aws:iam::558940753150:role/lambda-full-acces"
    },
    {
      name            = "function2"
      handler         = "function2.lambda_handler"
      runtime         = "python3.8"
      source_code_hash = data.archive_file.function2_archive.output_base64sha256
      role = "arn:aws:iam::558940753150:role/lambda-full-acces"
    }
  ]
}
