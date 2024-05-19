# frozen_string_literal: true

module SepaFileParser
  module Pain001
    class PaymentInformation

      attr_reader :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
      end

      def identification
        @identification ||= xml_data.xpath('PmtInfId/text()').text
      end

      def requested_execution_date
        @requested_execution_date ||= Time.parse(xml_data.xpath('ReqdExctnDt/text()').text)
      end

      def account
        @account ||= SepaFileParser::Account.from_pain_data(
                       xml_data,
                       xml_data.xpath('CdtTrfTxInf/Amt/InstdAmt/@Ccy').first,
                       'Dbtr',
                     )
      end

      def entries
        @entries ||= xml_data.xpath('CdtTrfTxInf').map do |x|
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
