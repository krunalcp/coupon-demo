class CouponAssignMailer < ApplicationMailer
  default from: 'maulik@softices.com'

  def coupon_assign_mail(employee_coupon)
    @employee_coupon = employee_coupon
    mail(
      to: @employee_coupon.employee.email,
      subject: 'Coupon Assign'
    )
  end
end
