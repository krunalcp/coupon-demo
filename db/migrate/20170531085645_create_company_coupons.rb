class CreateCompanyCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :company_coupons do |t|
      t.integer  :number_of_coupon
      t.integer  :company_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
    add_index :company_coupons, :number_of_coupon
    add_index :company_coupons, :company_id
  end
end
