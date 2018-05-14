class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include ResourceLayout
end
