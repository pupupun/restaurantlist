class OwnershipsController < ApplicationController
  def create
    @rest = Rest.find_or_initialize_by(shop_id: params[:shop_id])
    
    unless @rest.persisted?

      @shop_id = params[:shop_id]

      uri = base_uri + "&id=#{@shop_id}"
      uri = URI.escape(uri)
      result = (JSON.parse open(uri).read, {symbolize_names: true})[:rest]
      
      @rest = Rest.new(read(result))
      @rest.save!
    end
    
    if params[:type] == 'Interest'
      current_user.interest(@rest)
      flash[:success] = 'Interestしました。'
    end
    
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @rest = Rest.find_by(shop_id: params[:shop_id])

    if params[:type] == 'Interest'
      current_user.uninterest(@rest)
      flash[:success] = 'Interestを解除しました。'
    end
    
    redirect_back(fallback_location: root_url)
  end
end
