class CreateImportContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :import_contacts do |t|
      t.string :filename
      t.string :status
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
