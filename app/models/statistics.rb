class Statistics
  def initialize(events)
    @events = events
  end

  def total_negatives
    (Event.where(status: :processed, sentiment_score: -1..-0.6).count.to_f / @events.count) * 100
  end

  def total_positives
    (Event.where(status: :processed, sentiment_score: 0.6..1).count.to_f / @events.count) * 100
  end

  def estimated_nps
    promoters = Event.where(status: :processed, sentiment_score: 0.6..1).count.to_f
    detractors = Event.where(status: :processed, sentiment_score: -1..-0.6).count.to_f
    ((promoters - detractors) / @events.count) * 100
  end

  def last_month_total_negatives
    90
  end

  def last_month_total_positives
    15
  end

  def last_month_nps
    -62.5
  end

  def positives_percentage_change
    bool = last_month_total_positives < total_positives
    return ((total_positives - last_month_total_positives) / last_month_total_positives) * 100 if bool

    bool = last_month_total_positives > total_positives
    return ((last_month_total_positives - total_positives) / last_month_total_positives) * 100 if bool

    bool = last_month_total_positives == total_positives
    return 0 if bool
  end

  def negatives_percentage_change
    bool = last_month_total_negatives < total_negatives
    return ((total_negatives - last_month_total_negatives) / last_month_total_negatives) * 100 if bool

    bool = last_month_total_negatives > total_negatives
    return (( total_negatives) / last_month_total_negatives) * 100 if bool

    bool = last_month_total_negatives == total_negatives
    return 0 if bool
  end

  def nps_score_change
    estimated_nps - last_month_nps
  end
end
