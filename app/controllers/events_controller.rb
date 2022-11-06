class EventsController < ApplicationController
  before_action :set_events, only: :index
  before_action :set_statistics, only: :index

  def index
    @total_negatives = @statistics.percentage_negative_current_month
    @negatives_percentage_change = @statistics.negatives_percentage_change
    @total_positives = @statistics.percentage_positive_current_month
    @positives_percentage_change = @statistics.positives_percentage_change
    @estimated_nps = @statistics.estimated_nps
    @nps_score_change = @statistics.nps_score_change
  end

  private

  def set_events
    @events = Event.where(status: :processed).reverse
  end

  def set_statistics
    @statistics = Statistics.new(@events)
  end
end
