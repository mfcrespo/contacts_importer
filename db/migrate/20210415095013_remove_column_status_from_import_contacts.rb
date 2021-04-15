class RemoveColumnStatusFromImportContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :import_contacts, :status, :string
  end
end
