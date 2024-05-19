# frozen_string_literal: true

module SepaFileParser
  class String
    def self.parse(raw_camt)
      doc = Nokogiri::XML raw_camt
      SepaFileParser::Xml.parse(doc)
    end
  end
end
