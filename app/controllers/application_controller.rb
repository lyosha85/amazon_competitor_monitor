class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Account.first || Account.create(name: 'Alex')
  end
end
