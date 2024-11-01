resource "aws_sns_topic" "chips_training" {
  name = "chips_training"
}

resource "aws_sns_topic_subscription" "chips_training_system_Subscription" {
  topic_arn = aws_sns_topic.chips_training.arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.chips_training
  ]
}

resource "aws_sns_topic_subscription" "chips_training_system_Subscriptionhttps" {
  topic_arn = aws_sns_topic.chips_training.arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.chips_training
  ]
}
