class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.integer :company_id
      t.string  :prefix, limit: 4
      t.string  :first_name, limit: 50
      t.string  :last_name, limit: 50
      t.string  :middle_name, limit: 50
      t.string  :email, limit: 50
      t.string  :contact_number, limit: 20
      t.string  :address
      t.boolean :disabled, default: false
      t.timestamps
    end
    add_index :employees, :company_id
    add_index :employees, :email
    add_index :employees, :contact_number
  end
end
