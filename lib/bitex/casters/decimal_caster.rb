# Cast to decimal from string.
class DecimalCaster
  def self.cast(value, _default)
    raise NaNError unless value.is_a? Numeric

    BigDecimal(value.to_s)
  rescue NaNError
    '0'.to_d
  end
end

class NaNError < StandardError
end

JsonApiClient::Schema.register decimal: DecimalCaster
