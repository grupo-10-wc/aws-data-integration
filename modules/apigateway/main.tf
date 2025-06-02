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
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:us-east-1:s3:path/{bucket}/{filename}"
  credentials             = "arn:aws:iam::232922277588:role/LabRole"

  request_parameters = {
    "integration.request.path.bucket"   = "method.request.path.bucket"
    "integration.request.path.filename" = "method.request.path.filename"
  }

  request_templates = {
    "application/json" = "$input.body"
  }

}

resource "aws_api_gateway_method_response" "put_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.filename.id
  http_method = aws_api_gateway_method.put.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "put_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.filename.id
  http_method = aws_api_gateway_method.put.http_method
  status_code = aws_api_gateway_method_response.put_200.status_code

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_integration.put]
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id          = aws_api_gateway_rest_api.this.id
  deployment_id        = aws_api_gateway_deployment.this.id
  stage_name           = var.stage_name
}