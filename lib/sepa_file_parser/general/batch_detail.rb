# frozen_string_literal: true

module SepaFileParser
  class BatchDetail

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
      @amount = xml_data.xpath('TtlAmt/text()').text
    end

    def total_amount
      SepaFileParser::Misc.to_amount(@amount)
    end

    def total_amount_in_cents
      SepaFileParser::Misc.to_amount_in_cents(@amount)
    end

    # @return [String]
    def currency
      @currency ||= xml_data.xpath('TtlAmt/@Ccy').text
    end

    def payment_information_identification
      @payment_information_identification ||= xml_data.xpath('PmtInfId/text()').text
    end

    def msg_id # may be missing
      @msg_id ||= xml_data.xpath('MsgId/text()').text
    end
    alias_method :message_id, :msg_id # same like in transaction.rb

    def number_of_transactions
      @number_of_transactions ||= xml_data.xpath('NbOfTxs/text()').text
    end
  end  
end
