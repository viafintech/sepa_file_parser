# frozen_string_literal: true

module SepaFileParser
  class CreditorReferenceInformation

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def creditor_reference
      @creditor_reference ||= xml_data.xpath('Ref/text()').text
    end

    def code_or_proprietary
      @code_or_proprietary ||= [
        xml_data.xpath('Tp/CdOrPrtry/Cd/text()').text,
        xml_data.xpath('Tp/CdOrPrtry/Prtry/text()').text,
      ].reject(&:empty?).first.to_s
    end
  end  
end
