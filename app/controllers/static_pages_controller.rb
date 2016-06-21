class StaticPagesController < ApplicationController
  def index
    render "static_pages/home"
  end

  def signup
    render "static_pages/signup"
  end
end
