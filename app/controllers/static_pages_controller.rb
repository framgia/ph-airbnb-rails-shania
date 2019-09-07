class StaticPagesController < ApplicationController
  def home
    @properties = Property.all
  end
end
