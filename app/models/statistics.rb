class Statistics
  def initialize(events)
    @events = events
  end

  def percentage_negative_current_month
    return 0 if @events.count.zero?
    ((Event.where(status: :processed, sentiment_score: -1..-0.6).count.to_f / @events.count) * 100).round(2)
  end

  def percentage_positive_current_month
    return 0 if @events.count.zero?
    ((Event.where(status: :processed, sentiment_score: 0.6..1).count.to_f / @events.count) * 100).round(2)
  end

  def estimated_nps
    return 0 if @events.count.zero?
    promoters = Event.where(status: :processed, sentiment_score: 0.6..1).count.to_f
    detractors = Event.where(status: :processed, sentiment_score: -1..-0.6).count.to_f
    (((promoters - detractors) / @events.count) * 100).round(2)
  end

  def percentage_negative_last_month
    0
  end

  def percentage_positive_last_month
    0
  end

  def last_month_nps
    0
  end

  def positives_percentage_change
    (percentage_positive_last_month - percentage_positive_current_month).round(2)
  end

  def negatives_percentage_change
    (percentage_negative_last_month - percentage_negative_current_month).round(2)
  end

  def nps_score_change
    (estimated_nps - last_month_nps).round(2)
  end
end
