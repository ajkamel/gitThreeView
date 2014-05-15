class ReposController < ApplicationController

  before_action :signed_in?

  def index
  end

  def show
    @repo = Repo.all
  end

end
