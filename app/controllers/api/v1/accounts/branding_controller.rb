class Api::V1::Accounts::BrandingController < Api::V1::Accounts::BaseController
  before_action :check_admin_authorization?

  def show
    render json: branding_payload
  end

  def update
    updater = Accounting::BrandingUpdater.new(account: Current.account, params: branding_params)
    updater.update!
    update_attachments!
    render json: branding_payload
  end

  private

  def branding_payload
    account = Current.account
    {
      name: account.branding_name,
      installation_name: account.branding_installation_name,
      brand_url: account.branding_brand_url,
      widget_brand_url: account.branding_widget_brand_url,
      terms_url: account.branding_terms_url,
      privacy_url: account.branding_privacy_url,
      primary_color: account.branding_primary_color,
      logo_url: (url_for(account.logo) if account.logo.attached?),
      logo_dark_url: (url_for(account.logo_dark) if account.logo_dark.attached?),
      logo_thumbnail_url: (url_for(account.logo_thumbnail) if account.logo_thumbnail.attached?)
    }.compact
  end

  def branding_params
    params.fetch(:branding, {}).permit(
      :name,
      :installation_name,
      :brand_url,
      :widget_brand_url,
      :terms_url,
      :privacy_url,
      :primary_color
    )
  end

  def update_attachments!
    branding = params[:branding]
    return unless branding

    update_attachment(:logo, branding)
    update_attachment(:logo_dark, branding)
    update_attachment(:logo_thumbnail, branding)
  end

  def update_attachment(attribute, branding)
    remove_key = "remove_#{attribute}".to_sym
    attachment = branding[attribute]
    should_remove = ActiveModel::Type::Boolean.new.cast(branding[remove_key])

    if should_remove
      Current.account.public_send(attribute).purge if Current.account.public_send(attribute).attached?
    elsif attachment.present?
      Current.account.public_send(attribute).attach(attachment)
    end
  end
end
