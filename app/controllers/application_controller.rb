class ApplicationController < ActionController::Base
  ensure_security_headers
  protect_from_forgery
end
