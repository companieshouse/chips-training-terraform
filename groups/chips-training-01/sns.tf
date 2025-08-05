resource "aws_sns_topic" "chips_training_01" {
  name = "chips_training_01"
}

resource "aws_sns_topic_subscription" "chips_training_01_system_Subscription" {
  topic_arn = aws_sns_topic.chips_training_01.arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.chips_training_01
  ]
}

resource "aws_sns_topic_subscription" "chips_training_01_system_Subscriptionhttps" {
  topic_arn = aws_sns_topic.chips_training_01.arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.chips_training_01
  ]
}
