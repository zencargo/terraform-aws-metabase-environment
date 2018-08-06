# we have to duplicate the profile definition here
# as we can't interpolate the remote-state config.
profile                      = "zencargo"
region                       = "eu-west-1"
stage                        = "prod"
aws_account_id               = "980327139569"
ssl_certificate_id           = "arn:aws:acm:eu-west-1:980327139569:certificate/b27d0662-7036-4146-a77d-c08c1f471b32"
loadbalancer_certificate_arn = "arn:aws:acm:eu-west-1:980327139569:certificate/b27d0662-7036-4146-a77d-c08c1f471b32"
zone_id                      = "Z6K90IXG4OMCT"
ec2_key_name                 = "riethmayer@baldr"
