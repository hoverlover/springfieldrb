class HomeController < ApplicationController
  def index
    @members = Member.all
  end
end
