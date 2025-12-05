class AddBrandingToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :branding, :jsonb, null: false, default: {}
  end
end
