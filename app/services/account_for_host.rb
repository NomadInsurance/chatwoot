class AccountForHost
  class << self
    def call(raw_host)
      host = HostNormalizer.normalize(raw_host)
      return if host.blank?

      portal = Portal.find_by(custom_domain: host)
      return portal.account if portal

      AccountDomain.includes(:account).find_by(host: host)&.account
    end
  end
end
