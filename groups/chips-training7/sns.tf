resource "aws_sns_topic" "chips-training7_topic" {
  name = "chips-training7"
}

resource "aws_sns_topic_subscription" "chips-training7_Subscription" {
  topic_arn = aws_sns_topic.chips-training7_topic.arn
  for_each  = toset(["charris1@companieshouse.gov.uk", "ccullinane@companieshouse.gov.uk","noconnor@companieshouse.gov.uk","sharrison1@companieshouse.gov.uk"])
  protocol  = "email"
  endpoint  = each.value

  depends_on = [
    aws_sns_topic.chips-training7_topic
  ]
}

resource "aws_sns_topic_subscription" "chips-training7_Subscriptionhttps" {
  topic_arn = aws_sns_topic.chips-training7_topic.arn
  protocol  = "https"
    endpoint  = data.vault_generic_secret.sns_url.data["url"]

  depends_on = [
    aws_sns_topic.chips-training7_topic
  ]
}