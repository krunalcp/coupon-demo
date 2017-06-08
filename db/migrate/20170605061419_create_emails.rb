class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string   :email, limit: 50
      t.datetime :send_date
      t.string   :otp, limit: 4
      t.boolean  :verified, default: false

      t.timestamps
    end
  end
end
