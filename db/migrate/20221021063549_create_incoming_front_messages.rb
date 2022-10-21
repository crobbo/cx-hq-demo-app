class CreateIncomingFrontMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :incoming_front_messages do |t|
      t.string :sender_name
      t.string :sender_email
      t.string :recipient_name
      t.string :recipient_email
      t.text :message
      t.string :message_url

      t.timestamps
    end
  end
end
