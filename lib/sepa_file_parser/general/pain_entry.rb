# frozen_string_literal: true

module SepaFileParser
  class PainEntry

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
      @amount = xml_data.xpath('Amt/InstdAmt/text()').text
    end

    def amount
      SepaFileParser::Misc.to_amount(@amount)
    end

    def amount_in_cents
      SepaFileParser::Misc.to_amount_in_cents(@amount)
    end

    # @return [String]
    def currency
      @currency ||= xml_data.xpath('Amt/InstdAmt/@Ccy').text
    end

    def account
      @account ||= SepaFileParser::Account.from_pain_data(
                     xml_data,
                     currency,
                     'Cdtr',
                   )
    end

    def remittance_information
      @remittance_information ||= xml_data.xpath('RmtInf/Ustrd').text
    end

  end
end
