class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  API_SECRET = Rails.application.credentials.front[:secret]

  before_action do
    validateFrontSignature(request.body.read, request.headers['X-Front-Signature'])
  end

  def create
    if @valid_request
      event = Event.create!(
        data: params,
        source: params[:source]
      )
      HandleEventJob.perform_later(event)
      render json: { status: :ok }
    else
      render json: { status: :forbidden }
    end
  end

  private

  def validateFrontSignature(data, signature)
    @valid_request = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), API_SECRET, data)).strip() == signature ? true : false
  end
end
