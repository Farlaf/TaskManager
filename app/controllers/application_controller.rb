require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
end
