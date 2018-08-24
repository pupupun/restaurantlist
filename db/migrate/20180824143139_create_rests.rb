class CreateRests < ActiveRecord::Migration[5.0]
  def change
    create_table :rests do |t|
      t.string :shop_id
      t.string :name
      t.string :address
      t.string :tel
      t.string :shop_image1
      t.string :shop_image2
      t.string :qrcode

      t.timestamps
    end
  end
end
