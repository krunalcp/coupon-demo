class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string   :code, limit: 50
      t.datetime :expiry_date
      t.string   :description
      t.string   :vendor, limit: 100
      t.timestamps
    end
    add_index :coupons, :code
    add_index :coupons, :expiry_date
    add_index :coupons, :vendor
  end
end
