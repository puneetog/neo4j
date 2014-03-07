class StaticPagesController < ApplicationController
  def home
    @micropost = Micropost.new if signed_in?
  end
end
