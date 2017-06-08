class CompanyCoupon < ApplicationRecord
  #
  ## Associations
  #
  belongs_to(
    :company
  )
  has_one(
    :company_coupon_rule
  )
  has_many(
    :employee_coupon
  )

  #
  ## Validations
  #
  validates(
    :company_id,
    presence: true
  )
  validates(
    :number_of_coupon,
    presence: true
  )
  validates(
    :start_date,
    presence: true
  )
  validates(
    :end_date,
    presence: true
  )
  validate :check_satrt_date_and_end_date

  def check_satrt_date_and_end_date
    date = DateTime.now
    company_coupon =  CompanyCoupon.where(
                        company_id: company_id
                      ).where(
                        "start_date <= ? and end_date >= ?",
                        date,
                        date
                      )
    unless company_coupon.blank?
      errors.add(:start_date, "record already availabe")
    end
  end
end
