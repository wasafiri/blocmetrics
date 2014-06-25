class AddAppNameToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_name, :string
    add_column :apps, :app_desc, :text
  end
end
