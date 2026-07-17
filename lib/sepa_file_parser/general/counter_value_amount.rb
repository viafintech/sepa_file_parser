# frozen_string_literal: true

module SepaFileParser
  class CounterValueAmount

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
      @amount = xml_data.xpath('Amt/text()').text
    end

    def amount
      SepaFileParser::Misc.to_amount(@amount)
    end

    def amount_in_cents
      SepaFileParser::Misc.to_amount_in_cents(@amount)
    end

    def exchange_rate
      @exchange_rate ||= SepaFileParser::Misc.to_amount(xml_data.xpath('CcyXchg/XchgRate/text()').text)
    end

    def source_currency
      @source_currency ||= xml_data.xpath('CcyXchg/SrcCcy/text()').text
    end

    def target_currency
      @target_currency ||= xml_data.xpath('CcyXchg/TrgtCcy/text()').text
    end
  end
end
