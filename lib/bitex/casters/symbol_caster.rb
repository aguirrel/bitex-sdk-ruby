# Cast to decimal from string.
class SymbolCaster
  def self.cast(value, _default)
    raise NoStringError unless value.is_a?(String)

    value.downcase.to_sym
  rescue NoStingError
    value
  end
end

class NoStringError < StandardError
end

JsonApiClient::Schema.register symbol: SymbolCaster
