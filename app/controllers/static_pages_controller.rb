class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user

  def error
    if params[:code]
      render "404", status: 404
    else
      render "500", status: 500
    end
  end
end
