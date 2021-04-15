class CreateRejectedContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :rejected_contacts do |t|
      t.string :name
      t.string :birthday
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :last_digits
      t.string :franchise
      t.string :email
      t.string :error
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
