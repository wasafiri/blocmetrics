class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :ip_address
      t.string :web_property_id
      t.string :action
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
