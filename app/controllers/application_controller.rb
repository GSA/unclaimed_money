class ApplicationController < ActionController::Base
  ensure_security_headers
  skip_before_filter :set_csp_header
  protect_from_forgery
end
