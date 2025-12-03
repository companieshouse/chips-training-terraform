resource "aws_sns_topic" "training_db_envt25" {
  name = "training_db_envt25"
}

resource "aws_sns_topic_subscription" "training_db_envt25_system_Subscription" {
  topic_arn = aws_sns_topic.training_db_envt25.arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.training_db_envt25
  ]
}

resource "aws_sns_topic_subscription" "training_db_envt25_system_Subscriptionhttps" {
  topic_arn = aws_sns_topic.training_db_envt25.arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.training_db_envt25
  ]
}
