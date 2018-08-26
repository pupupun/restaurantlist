class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  require 'open-uri'
  require 'uri'
  require 'json'
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    shop_id = result[:id]
    name = result[:name]
    address = result[:address]
    tel = result[:tel]
    shop_image1 = result[:image_url][:shop_image1]
    shop_image2 = result[:image_url][:shop_image2]
    shop_image2 = result[:image_url][:shop_image1] if shop_image2 == {}
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
  
  def base_uri
    "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV["GURUNAVI_KEY_ID"]}&format=json"
  end
end
