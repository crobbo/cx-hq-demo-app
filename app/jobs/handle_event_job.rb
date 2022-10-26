class HandleEventJob < ApplicationJob
  queue_as :default

  

  def perform(event)
    case event.source
    when 'front'
      handle_front_event(event)
    end
  end

  def handle_front_event(event)
    
  end

end
