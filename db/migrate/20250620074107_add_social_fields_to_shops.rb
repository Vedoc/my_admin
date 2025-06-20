class AddSocialFieldsToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :facebook, :string
    add_column :shops, :instagram, :string
    add_column :shops, :hiring_email, :string
    add_column :shops, :stripe_token, :string
    add_reference :shops, :user, foreign_key: true
  end
end
