# frozen_string_literal: true

module SepaFileParser
  class Charges

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
      @total_charges_and_tax_amount = xml_data.xpath('TtlChrgsAndTaxAmt/text()').text
    end

    def total_charges_and_tax_amount
      SepaFileParser::Misc.to_amount(@total_charges_and_tax_amount)
    end

    def total_charges_and_tax_amount_in_cents
      SepaFileParser::Misc.to_amount_in_cents(@total_charges_and_tax_amount)
    end

    def records
      @records ||= xml_data.xpath('Rcrd').map{ |x| SepaFileParser::Record.new(x) }
    end
  end
end
