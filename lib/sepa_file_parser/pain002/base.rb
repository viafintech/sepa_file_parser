# frozen_string_literal: true

module SepaFileParser
  module Pain002
    class Base
      attr_reader :group_header, :group_information_and_status, :payment_information_and_status, :xml_data

      # In order not to destroy old implementations
      alias_method :reports, :payment_information_and_status

      def initialize(xml_data)
        @xml_data = xml_data
        # CstmrPmtStsRpt = Customer Payment Status Report
        grphdr = xml_data.xpath('CstmrPmtStsRpt/GrpHdr')
        @group_header = SepaFileParser::GroupHeader.new(grphdr)

        payment_information_and_status = xml_data.xpath('CstmrPmtStsRpt/OrgnlPmtInfAndSts')
        @payment_information_and_status = payment_information_and_status.map { |x| PaymentInformation.new(x) }

        group_information_and_status = xml_data.xpath('CstmrPmtStsRpt/OrgnlGrpInfAndSts')
        @group_information_and_status = group_information_and_status.map { |x| GroupInformation.new(x) }
      end
    end
  end
end
