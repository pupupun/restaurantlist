class RestsController < ApplicationController
  
  def show
    @rest = Rest.find(params[:id])
    @interest_users = @rest.interest_users
  end

  def new
    @keyword = params[:keyword]
    if @keyword.present?
      uri = base_uri + "&freeword=#{@keyword}"
      uri = URI.escape(uri)
      results = JSON.parse open(uri).read, {symbolize_names: true}
      results = results[:rest]
      
      @rests = []
      results.each do |result|
        rest = Rest.new(read(result))
        @rests << rest
      end
    end
  end
end
