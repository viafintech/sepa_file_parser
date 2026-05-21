# frozen_string_literal: true

module SepaFileParser

  class Owner

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    # @return [String]
    def name
      @name ||= xml_data.xpath('Nm/text()').text
    end

    # @return [SepaFileParser::PostalAddress, nil]
    def postal_address # May be missing
      postal_address = xml_data.xpath('PstlAdr')

      return nil if postal_address == nil || postal_address.empty?

      @address ||= SepaFileParser::PostalAddress.new(postal_address)
    end
  end
end
