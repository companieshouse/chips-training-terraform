resource "aws_sns_topic" "chips_training_db" {
  name = "chips_training_db"
}

resource "aws_sns_topic_subscription" "chips_training_db_system_Subscription" {
  topic_arn = aws_sns_topic.chips_training_db.arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.chips_training_db
  ]
}

resource "aws_sns_topic_subscription" "chips_training_db_system_Subscriptionhttps" {
  topic_arn = aws_sns_topic.chips_training_db.arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.chips_training_db
  ]
}
