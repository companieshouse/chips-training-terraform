# ------------------------------------------------------------------------------
# SSH Key Pair
# ------------------------------------------------------------------------------

resource "aws_key_pair" "ec2_keypair" {
  key_name   = "chips-training7"
  public_key = local.ec2_data["public-key"]
}
