class EmployeeCoupon < ApplicationRecord
  #
  ## Associations
  #
  belongs_to(
    :employee
  )
  belongs_to(
    :coupon
  )
  belongs_to(
    :company_coupon
  )

  #
  ## Validations
  #
  validates(
    :employee_id,
    presence: true
  )
  validates(
    :coupon_id,
    presence: true,
    uniqueness: true
  )

  #
  ## Call back
  #
  after_save :coupon_mail_to_employee

  #
  # coupon mail send to employee
  #
  def coupon_mail_to_employee
    CouponAssignMailer.coupon_assign_mail(self).deliver
  end
end
