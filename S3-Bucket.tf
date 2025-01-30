
# Creating a S3 bucket
# Bucket name should be unique to the region.


resource "aws_s3_bucket" "terra-buckett243" {
  bucket = "terra-buckett243"

  tags = {
    Name = "terra-buckett243"
  }
}

# Creating a S3 Backend for storing the state file




# Giving Permssions to AWS S3 bucket

resource "aws_iam_policy" "s3example_bucket_policy" {

  name        = "s3example_bucket_policy"
  description = "IAM policy for S3 bucket access"

  policy = jsonencode(
    {

      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "s3:ListBucket",
          "Resource" : "arn:aws:s3:::terra-buckett243"
        },
        {
          "Effect" : "Allow",
          "Action" : ["s3:GetObject", "s3:PutObject"],
          "Resource" : [
            "arn:aws:s3:::terra-buckett243/TerraState.tfstate",
            "arn:aws:s3:::terra-buckett243/TerraState.tflock"
          ]
        }
      ]
    }
  )
}


resource "aws_iam_role" "S3_bucketexample_role" {
  name = "S3_bucketexample_role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy_attachment" "s3example_bucket_policy" {
  name       = "s3example_bucket_policy"
  policy_arn = aws_iam_policy.s3example_bucket_policy.arn
  roles      = [aws_iam_role.S3_bucketexample_role.name]
}




