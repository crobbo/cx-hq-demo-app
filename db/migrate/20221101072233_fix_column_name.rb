class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :message_url, :front_message_id
  end
end
