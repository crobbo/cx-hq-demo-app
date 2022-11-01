class EventsController < ApplicationController

  before_action :set_events, only: :index

  def index
  end

  private

  def set_events
    @events = Event.where(status: :processed, sentiment_score: -1..-0.000000000001).reverse
  end
end
