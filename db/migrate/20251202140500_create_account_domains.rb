class CreateAccountDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :account_domains do |t|
      t.references :account, null: false, foreign_key: true
      t.string :host, null: false

      t.timestamps
    end

    add_index :account_domains, :host, unique: true
  end
end
