# frozen_string_literal: true

module SepaFileParser
  class UltimateDebitor

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= [
        xml_data.xpath('RltdPties/UltmtDbtr/Nm/text()').text,
        xml_data.xpath('RltdPties/UltmtDbtr/Pty/Nm/text()').text,
      ].reject(&:empty?).first.to_s
    end

    # @return [SepaFileParser::PostalAddress, nil]
    def postal_address # May be missing
      postal_address = [
        xml_data.xpath('RltdPties/Dbtr/PstlAdr'),
        xml_data.xpath('RltdPties/Dbtr/Pty/PstlAdr'),
      ].reject(&:empty?).first

      return nil if postal_address == nil || postal_address.empty?

      @address ||= SepaFileParser::PostalAddress.new(postal_address)
    end
  end
end
