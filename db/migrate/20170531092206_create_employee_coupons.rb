class CreateEmployeeCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_coupons do |t|
      t.integer :coupon_id
      t.integer :employee_id
      t.integer :company_coupon_id
      t.timestamps
    end
    add_index :employee_coupons, :coupon_id
    add_index :employee_coupons, :employee_id
    add_index :employee_coupons, :company_coupon_id
  end
end
