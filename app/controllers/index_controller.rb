class IndexController < ApplicationController
  def index
    if !signed_in?
      redirect_to "/sign_in"
    end
  end
end