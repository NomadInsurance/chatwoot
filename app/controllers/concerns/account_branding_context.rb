module AccountBrandingContext
  extend ActiveSupport::Concern

  private

  def branding_account_for_request
    AccountForHost.call(request.host)
  end
end
