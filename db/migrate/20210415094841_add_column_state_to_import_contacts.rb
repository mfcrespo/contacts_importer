class AddColumnStateToImportContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :import_contacts, :state, :string
  end
end
