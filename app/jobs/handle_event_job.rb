class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.source
    when 'front'
      handle_front_event(event)
    end
  end

  def handle_front_event(event)
    # in here I will call a service that will handle the event
    # create a  GoogleAPI service object
  end
end
