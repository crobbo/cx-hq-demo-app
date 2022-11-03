class EventsController < ApplicationController
  before_action :set_events, only: :index
  before_action :set_statistics, only: :index

  def index
    @total_negatives = @statistics.total_negatives
    @negatives_percentage_change = @statistics.negatives_percentage_change
    @total_positives = @statistics.total_positives
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
