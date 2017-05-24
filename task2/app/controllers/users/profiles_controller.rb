class Users::ProfilesController < ApplicationController
  expose_decorated :user
  expose_decorated :users, -> { fetch_users }

  def show

  end

  private

  def fetch_users
    users = User.all
    users
  end
end
