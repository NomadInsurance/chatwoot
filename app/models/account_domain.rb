class AccountDomain < ApplicationRecord
  belongs_to :account

  before_validation :normalize_host

  validates :host, presence: true, uniqueness: true

  private

  def normalize_host
    return if host.blank?

    normalized = HostNormalizer.normalize(host)
    self.host = normalized if normalized
  end
end
