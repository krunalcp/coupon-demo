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
    if !self.start_date.blank? and !self.end_date.blank?
      company_coupon =  CompanyCoupon.where(
                          company_id: self.company_id
                        ).where(
                          '( (start_date <= ? and end_date >= ?) or ' +
                          '(start_date <= ? and end_date >= ?) or ' +
                          '(start_date >= ? and end_date <= ?) )',
                          self.start_date,
                          self.start_date,
                          self.end_date,
                          self.end_date,
                          self.start_date,
                          self.end_date
                        )
      if (self.new_record? and !company_coupon.blank?) or
          (!company_coupon.where.not(id: self.id).blank? )
        errors.add(:start_date, "dates are already exists!")
        errors.add(:end_date, "dates are already exists!")
      end
    end
  end
end
