class Coupon < ApplicationRecord

  #
  ## Associations
  #
  has_many(
    :company_coupons,
    dependent: :destroy
  )
  has_many(
    :employee_coupons,
    dependent: :destroy
  )
  has_many(
    :company_coupon_rules,
    dependent: :destroy
  )

  #
  ## Validations
  #
  validates(
    :code,
    presence: true,
    uniqueness: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :expiry_date,
    presence: true
  )
  validates(
    :vendor,
    presence: true,
    length: {
      maximum: 100
    }
  )
end
