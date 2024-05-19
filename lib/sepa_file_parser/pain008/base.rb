# frozen_string_literal: true

module SepaFileParser
  module Pain008
    class Base
      attr_reader :group_header, :payment_informations, :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
        # CstmrDrctDbtInitn = Customer Direct Debig Initiation
        grphdr = xml_data.xpath('CstmrDrctDbtInitn/GrpHdr')
        @group_header = SepaFileParser::GroupHeader.new(grphdr)
        payment_informations = xml_data.xpath('CstmrDrctDbtInitn/PmtInf')
        @payment_informations = payment_informations.map{ |x| PaymentInformation.new(x) }
      end
    end
  end
end
