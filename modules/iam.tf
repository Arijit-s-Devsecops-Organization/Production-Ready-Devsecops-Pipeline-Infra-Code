/* <--------- IAM Roles for the main ec2 instances ---------> */
resource "aws_iam_role" "ec2_role" {
   name = "ec2-role"

  # Trust policy allowing EC2 to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-policy"
  path        = "/"
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "iam:*",
          "eks:*",
          "s3:*",
          "dynamodb:*",
          "lambda:*",
          "cloudwatch:*",
          "logs:*"
        ]
        Effect   = "Allow"
        Resource = "${aws_instance.jenkins_instance.arn}"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "jenkins-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

