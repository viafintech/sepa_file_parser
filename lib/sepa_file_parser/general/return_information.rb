# frozen_string_literal: true

module SepaFileParser
  class ReturnInformation

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def additional_information # May be missing
      @additional_information ||= xml_data.xpath('AddtlInf/text()').text
    end

    def reason_code
      @reason_code ||= xml_data.xpath('Rsn/Cd/text()').text
    end
  end
end
