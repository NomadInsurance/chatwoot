require 'administrate/base_dashboard'

class AccountDomainDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    account: Field::BelongsTo,
    host: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    host
    account
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    host
    account
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    account
    host
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(account_domain)
    "#{account_domain.host} (##{account_domain.account_id})"
  end
end
