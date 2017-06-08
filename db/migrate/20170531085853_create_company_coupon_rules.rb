class CreateCompanyCouponRules < ActiveRecord::Migration[5.0]
  def change
    create_table :company_coupon_rules do |t|
      t.integer :company_coupon_id
      t.integer :allowed_coupon
      t.integer :duration
      t.timestamps
    end
    add_index :company_coupon_rules, :company_coupon_id
  end
end
