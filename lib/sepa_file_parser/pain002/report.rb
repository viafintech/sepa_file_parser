# frozen_string_literal: true

module SepaFileParser
  module Pain002
    class Report

      attr_reader :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
      end

      def original_identification
        @original_identification ||= xml_data.xpath('OrgnlPmtInfId/text()').text
      end

      def status_id
        @status_id ||= xml_data.xpath('TxInfAndSts/StsId/text()').text
      end

      def transaction_status
        @transaction_status ||= xml_data.xpath('TxInfAndSts/TxSts/text()').text
      end

      def source
        xml_data.to_s
      end

    end
  end
end
