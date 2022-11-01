class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.source
    when 'front'
      event.status = :processing
      handle_front_event(event)
    end
  end

  def handle_front_event(event)
    score = GoogleManager::SentimentChecker.call(event.data['target']['data']['text'])
    if score
      event.sender_email = event.data['conversation']['recipient']['handle']
      event.front_message_id = event.data['target']['data']['id']
      event.sentiment_score = score
      event.status = :processed
    else
      event.status = :failed
    end
    event.save
  end
end
