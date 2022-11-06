class Event < ApplicationRecord
  enum :status, {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed',
    failed: 'failed'
  }, default: 'pending'

  after_commit :broadcast

  def broadcast
    return unless status == 'processed'

    broadcast_prepend_to :events, target: 'event_stream', partial: 'events/event', locals: { event: self }
    @statistics = Statistics.new(Event.where(status: :processed))

    broadcast_update_to :events, target: 'negative_sentiment_stat', partial: 'shared/negative_sentiment',
                                 locals: { total_negatives: @statistics.percentage_negative_current_month,
                                           negatives_percentage_change: @statistics.negatives_percentage_change}

    broadcast_update_to :events, target: 'positive_sentiment_stat', partial: 'shared/positive_sentiment',
                                 locals: { total_positives: @statistics.percentage_positive_current_month,
                                           positives_percentage_change: @statistics.positives_percentage_change }

    broadcast_update_to :events, target: 'nps_stat', partial: 'shared/estimated_nps',
                                 locals: { estimated_nps: @statistics.estimated_nps, 
                                           nps_score_change: @statistics.nps_score_change }
  end
end
