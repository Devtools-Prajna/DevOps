resource "aws_sns_topic" "notification_topic" {
  name = "devops-ecs-topic"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.notification_topic.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}