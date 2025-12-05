class Api::V1::Widget::ConfigsController < Api::V1::Widget::BaseController
  before_action :set_global_config

  def create
    build_contact
    set_token
  end

  private

  def set_global_config
    base_config = GlobalConfig.get(
      'MAXIMUM_FILE_UPLOAD_SIZE'
    )

    branding = BrandingConfig.new(account: @web_widget.inbox.account).to_global_config_hash
    @global_config = base_config.merge(branding)
  end

  def set_contact
    @contact_inbox = @web_widget.inbox.contact_inboxes.find_by(
      source_id: auth_token_params[:source_id]
    )
    @contact = @contact_inbox&.contact
  end

  def build_contact
    return if @contact.present?

    @contact_inbox = @web_widget.create_contact_inbox(additional_attributes)
    @contact = @contact_inbox.contact
  end

  def set_token
    payload = { source_id: @contact_inbox.source_id, inbox_id: @web_widget.inbox.id }
    @token = ::Widget::TokenService.new(payload: payload).generate_token
  end

  def additional_attributes
    if @web_widget.inbox.account.feature_enabled?('ip_lookup')
      { created_at_ip: request.remote_ip }
    else
      {}
    end
  end
end
