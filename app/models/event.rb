class Event < ApplicationRecord
  enum :status, {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed',
    failed: 'failed'
  }, default: 'pending'

  def processed_events
    Event.where(status: :processed)
  end
end
