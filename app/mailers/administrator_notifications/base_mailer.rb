class AdministratorNotifications::BaseMailer < ApplicationMailer
  # Common method to check SMTP configuration and send mail with liquid
  def send_notification(subject, to: nil, action_url: nil, meta: {})
    return unless smtp_config_set_or_development?

    @action_url = action_url
    @meta = meta || {}

    send_mail_with_liquid(to: to || admin_emails, subject: subject) and return
  end

  # Helper method to generate inbox URL
  def inbox_url(inbox)
    "#{ENV.fetch('FRONTEND_URL', nil)}/app/accounts/#{branding_account.id}/settings/inboxes/#{inbox.id}"
  end

  # Helper method to generate settings URL
  def settings_url(section)
    "#{ENV.fetch('FRONTEND_URL', nil)}/app/accounts/#{branding_account.id}/settings/#{section}"
  end

  private

  def branding_account
    @account || Current.account
  end

  def admin_emails
    branding_account.administrators.pluck(:email)
  end

  def liquid_locals
    super.merge({ meta: @meta })
  end
end
