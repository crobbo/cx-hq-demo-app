class AddUrlAndSenderToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :message_url, :string
    add_column :events, :sender_email, :string
  end
end
