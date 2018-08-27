class ToppagesController < ApplicationController
  def index
    @rests = Rest.order('updated_at DESC')
  end
end
