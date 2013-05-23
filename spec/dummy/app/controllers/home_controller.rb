class HomeController < ApplicationController
  
  def index
    render text: 'Home Controller', layout: true
  end
  
  def login
    session[:user_id] = params.fetch(:id)
    redirect_to action: 'index'
  end
end