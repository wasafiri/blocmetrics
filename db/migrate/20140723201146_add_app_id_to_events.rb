class AddAppIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :app_id, :integer
  end
end
