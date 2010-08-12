class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_all_users_hash
     Hash[*User.all.map{|u| [u.id, u.email]}.flatten]
  end
end
