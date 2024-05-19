# frozen_string_literal: true

module SepaFileParser
  module Pain008
    class PaymentInformation

      attr_reader :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
      end

      def identification
        @identification ||= xml_data.xpath('PmtInfId/text()').text
      end

      def requested_collection_date
        @requested_collection_date ||= Time.parse(xml_data.xpath('ReqdColltnDt/text()').text)
      end

      def account
        @account ||= SepaFileParser::Account.from_pain_data(
                       xml_data,
                       entries.first.currency,
                       'Cdtr',
                     )
      end

      def entries
        @entries ||= xml_data.xpath('DrctDbtTxInf').map do |x|
                       SepaFileParser::PainEntry.new(x)
                     end
      end

      def source
        xml_data.to_s
      end

      def self.parse(xml)
        self.new(Nokogiri::XML(xml).xpath('PmtInf'))
      end
    end
  end
end
