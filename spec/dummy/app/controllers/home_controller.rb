class HomeController < ApplicationController
  
  def index
    render text: 'Home Controller', layout: true
  end
  
end