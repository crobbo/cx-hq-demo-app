module GoogleManager
  # app/services/sentiment_checker.rb
  class SentimentChecker < ApplicationService
    attr_reader :text 

    def initialize(text)
      @text = text
    end

    def call
      puts @text
    end
  end
end