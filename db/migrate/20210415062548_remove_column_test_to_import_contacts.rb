class RemoveColumnTestToImportContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :import_contacts, :test, :text
  end
end
