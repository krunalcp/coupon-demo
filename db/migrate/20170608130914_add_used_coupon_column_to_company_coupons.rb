class AddUsedCouponColumnToCompanyCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :company_coupons, :used_coupon, :integer, default: 0
  end
end
