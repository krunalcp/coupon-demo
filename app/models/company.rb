class Company < ApplicationRecord
  #
  ## Associations
  #
  has_many(
    :company_coupons,
    dependent: :destroy
  )
  has_many(
    :employees,
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
    :name,
    presence: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :email,
    format: {
      with: EMAIL_REGEX
    },
    presence: true,
    uniqueness: true,
    length: {
      maximum: 50
    }
  )
  validates(
    :contact_number,
    presence: true,
    length: {
      maximum: 20
    }
  )
  validates(
    :domain,
    presence: true,
    uniqueness: true,
    length: {
      maximum: 50
    }
  )
end
