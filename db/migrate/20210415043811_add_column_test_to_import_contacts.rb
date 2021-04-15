class AddColumnTestToImportContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :import_contacts, :test, :text
  end
end
