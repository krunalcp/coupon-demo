class CouponAssignMailer < ApplicationMailer
  def coupon_assign_mail(employee_coupon)
    @employee_coupon = employee_coupon
    mail(
      to: @employee_coupon.try(:employee).try(:email),
      subject: 'Coupon Assign'
    )
  end
end
