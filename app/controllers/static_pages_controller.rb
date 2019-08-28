class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:reservations, :trips]
  def home
  end
end
