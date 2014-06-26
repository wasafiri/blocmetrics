class AddAppNameToApps < ActiveRecord::Migration
  def change
    add_column :apps, :name, :string
    add_column :apps, :desc, :text
  end
end
