# Cast to decimal from string.
class DecimalCaster
  def self.cast(value, _default)
    raise unless value.is_a? Numeric

    BigDecimal.new(value.to_s)
  rescue
    '0'.to_d
  end
end

JsonApiClient::Schema.register decimal: DecimalCaster
