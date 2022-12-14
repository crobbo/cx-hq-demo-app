module GoogleManager
  # app/services/sentiment_checker.rb
  class SentimentChecker < ApplicationService
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def call
      client = Google::Cloud::Language.language_service
      score = client.analyze_sentiment(document: { content: @text, type: :PLAIN_TEXT }).document_sentiment.score
      return false unless score

      score
    end
  end
end
