# frozen_string_literal: true

module SepaFileParser
  module Pain002
    class Base
      attr_reader :group_header, :reports, :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
        # CstmrPmtStsRpt = Customer Payment Status Report
        grphdr = xml_data.xpath('CstmrPmtStsRpt/GrpHdr')
        @group_header = SepaFileParser::GroupHeader.new(grphdr)
        reports = xml_data.xpath('CstmrPmtStsRpt/OrgnlPmtInfAndSts')
        @reports = reports.map { |x| Report.new(x) }
      end
    end
  end
end
