# we have to duplicate the profile definition here
# as we can't interpolate the remote-state config.

profile            = "zencargo-stage"
region             = "eu-west-1"
environment        = "stage"
ssl_certificate_id = "arn:aws:acm:eu-west-1:722849216534:certificate/de838717-c5fd-4d8b-810a-cadd54dc6634"
