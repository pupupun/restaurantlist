class RestsController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'json'

  def new
    base_uri = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV["GURUNAVI_KEY_ID"]}&format=json"
    
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
  
  private

  def read(result)
    shop_id = result[:id]
    name = result[:name]
    address = result[:address]
    tel = result[:tel]
    shop_image1 = result[:image_url][:shop_image1]
    shop_image2 = result[:image_url][:shop_image1]
    qrcode = result[:qrcode]

    {
      shop_id: shop_id,
      name: name,
      address: address,
      tel: tel,
      shop_image1: shop_image1,
      shop_image2: shop_image2,
      qrcode: qrcode
    }
  end
end
