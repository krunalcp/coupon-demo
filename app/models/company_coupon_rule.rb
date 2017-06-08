class CompanyCouponRule < ApplicationRecord
  #
  ## Associations
  #
  belongs_to(
    :company_coupon
  )

  #
  ## Validations
  #
  validates(
    :allowed_coupon,
    presence: true
  )
  validates(
    :duration,
    presence: true
  )

  #
  ## Method for create company coupon rule
  #
  def self.create_company_coupon_rule(company_coupon_id, rules)
    unless company_coupon_id.blank? && rules.blank?
      rule =  CompanyCouponRule.find_or_initialize_by(
                company_coupon_id: company_coupon_id
              )
      rule.allowed_coupon = rules[:allow_coupon]
      rule.duration       = rules[:duration] == "custom" ? rules[:custom_duration] : rules[:duration]
      rule.save
    end
  end
end
