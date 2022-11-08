class AddSentimentScoreColumnToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :sentiment_score, :float
  end
end
