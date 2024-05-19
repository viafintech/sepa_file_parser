# frozen_string_literal: true

module SepaFileParser
  class Account

    def self.from_camt_data(xml_data)
      self.new(
        iban:      xml_data.xpath('Id/IBAN/text()').text,
        other_id:  xml_data.xpath('Id/Othr/Id/text()').text,
        bic:       [
          xml_data.xpath('Svcr/FinInstnId/BIC/text()').text,
          xml_data.xpath('Svcr/FinInstnId/BICFI/text()').text,
        ].reject(&:empty?).first.to_s,
        bank_name: xml_data.xpath('Svcr/FinInstnId/Nm/text()').text,
        currency:  xml_data.xpath('Ccy/text()').text,
      )
    end

    def self.from_pain_data(xml_data, currency, context)
      self.new(
        iban:      xml_data.xpath("#{context}Acct/Id/IBAN/text()").text,
        bic:       xml_data.xpath("#{context}Agt/FinInstnId/BIC/text()").text,
        bank_name: xml_data.xpath("#{context}/Nm/text()").text,
        currency:  currency,
      )
    end

    def initialize(iban: nil, other_id: nil, bic:, bank_name:, currency:)
      @iban      = iban
      @other_id  = other_id
      @bic       = bic
      @bank_name = bank_name
      @currency  = currency
    end

    # @return [String]
    def iban
      @iban.to_s
    end

    # @return [String]
    def other_id
      @other_id.to_s
    end

    # @return [String]
    def account_number
      iban != '' ? iban : other_id
    end

    # @return [String]
    def bic
      @bic.to_s
    end

    # @return [String]
    def bank_name
      @bank_name.to_s
    end

    # @return [String]
    def currency
      @currency.to_s
    end
  end
end
