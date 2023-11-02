resource "aws_sns_topic" "chips-training25_topic" {
  name = "chips-training25"
}

resource "aws_sns_topic_subscription" "chips-training25_Subscription" {
  topic_arn = aws_sns_topic.chips-training25_topic.arn
  for_each  = toset(["linuxsupport@companieshouse.gov.uk"])
  protocol  = "email"
  endpoint  = each.value

  depends_on = [
    aws_sns_topic.chips-training25_topic
  ]
}

resource "aws_sns_topic_subscription" "chips-training25_Subscriptionhttps" {
  topic_arn = aws_sns_topic.chips-training25_topic.arn
  protocol  = "https"
    endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.chips-training25_topic
  ]
}