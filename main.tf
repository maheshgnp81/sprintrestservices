@@ -0,0 +1,49 @@
provider "aws" {
access_key = "test"
secret_key = "test"
region = "us-east-1"
}

# =====================================
variable "bucket_name" {
default = "maheshg-001"
}
#======================================

resource "aws_s3_bucket" "create-s3-bucket" {
bucket = "${var.bucket_name}"
acl = "private"
lifecycle_rule {
id = "archive"
enabled = true
transition {
days = 30
storage_class = "STANDARD_IA"
}
transition {
days = 60
storage_class = "GLACIER"
}

}

versioning {
enabled = true
}

tags = {
Environment : "QA"
}

server_side_encryption_configuration {
rule {
apply_server_side_encryption_by_default {
sse_algorithm = "aws:kms"
}
}
}



}
