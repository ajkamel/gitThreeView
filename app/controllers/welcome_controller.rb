class WelcomeController < ApplicationController

  def index
    @graphs = Graph.all
    @user = current_user
  end

end
