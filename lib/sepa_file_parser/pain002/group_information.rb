# frozen_string_literal: true

module SepaFileParser
  module Pain002
    class GroupInformation

      attr_reader :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
      end

      def message_id
        @message_id ||= xml_data.xpath('OrgnlMsgId/text()').text
      end

      def message_name_identification
        @message_name_identification ||= xml_data.xpath('OrgnlMsgNmId/text()').text
      end

      def status
        @status ||= xml_data.xpath('GrpSts/text()').text
      end

      def source
        xml_data.to_s
      end
    end
  end
end
