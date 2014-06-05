class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

end

