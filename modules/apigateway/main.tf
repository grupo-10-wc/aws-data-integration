resource "aws_api_gateway_rest_api" "this" {
  name          = var.api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  binary_media_types = ["application/json"]
}

resource "aws_api_gateway_resource" "bucket" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{bucket}"
}

resource "aws_api_gateway_resource" "filename" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.bucket.id
  path_part   = "{filename}"
}

resource "aws_api_gateway_method" "put" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.filename.id
  http_method   = "PUT"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.bucket"   = true
    "method.request.path.filename" = true
  }
}

resource "aws_api_gateway_integration" "put" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.filename.id
  http_method             = aws_api_gateway_method.put.http_method
  integration_http_method = "PUT"
  type                    = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_integration.put]
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name
}