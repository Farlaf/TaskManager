class ApplicationController < ActionController::Base
  include AuthHelper
  helper_method :current_user
end
