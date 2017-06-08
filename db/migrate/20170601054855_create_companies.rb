class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name, limit: 50
      t.string :email, limit: 50
      t.string :contact_number, limit: 20
      t.string :domain, limit: 50
      t.string :address
      t.timestamps
    end
    add_index :companies, :email
    add_index :companies, :contact_number
    add_index :companies, :domain
  end
end
