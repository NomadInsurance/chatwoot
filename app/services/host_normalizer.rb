module HostNormalizer
  module_function

  def normalize(raw_host)
    return if raw_host.blank?

    host = raw_host.split(':').first.downcase.chomp('.')
    host.presence
  end
end
