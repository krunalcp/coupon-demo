class CreateEmployeeOtps < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_otps do |t|
      t.string  :email, limit: 50
      t.string  :otp, limit: 6
      t.timestamps
    end
    add_index :employee_otps, :email
    add_index :employee_otps, :otp
  end
end
