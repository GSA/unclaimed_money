::SecureHeaders::Configuration.configure do |config|
  config.hsts = {:max_age => 13.years.to_i, :include_subdomains => true}
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = {:value => 1, :mode => 'block'}
  config.csp = false # disabled for now
  
  # see
  # https://github.com/twitter/secureheaders
  # https://www.owasp.org/index.php/Content_Security_Policy
  # http://www.html5rocks.com/en/tutorials/security/content-security-policy/
end