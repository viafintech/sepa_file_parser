# frozen_string_literal: true

module SepaFileParser
  class BankTransactionCode

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def domain_code # May be missing
      @domain_code ||= xml_data.xpath('Domn/Cd/text()').text
    end

    def family_code # May be missing
      @family_code ||= xml_data.xpath('Domn/Fmly/Cd/text()').text
    end

    def sub_family_code # May be missing
      @sub_family_code ||= xml_data.xpath('Domn/Fmly/SubFmlyCd/text()').text
    end
  end
end
