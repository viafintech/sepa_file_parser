# frozen_string_literal: true

module SepaFileParser
  class Xml
    PARSER_MAPPING = {
      camt052: SepaFileParser::Camt052::Base,
      camt053: SepaFileParser::Camt053::Base,
      camt054: SepaFileParser::Camt054::Base,
      pain001: SepaFileParser::Pain001::Base,
    }.freeze

    SUPPORTED_PARSERS = PARSER_MAPPING.keys.freeze

    @namespace_parsers = {}

    def self.register(namespace, parser)
      if !SUPPORTED_PARSERS.include?(parser)
        raise SepaFileParser::Errors::UnsupportedParserClass, parser.to_s
      end

      if @namespace_parsers.key?(namespace) # Prevent overwriting existing registrations
        raise SepaFileParser::Errors::NamespaceAlreadyRegistered, namespace
      end

      @namespace_parsers[namespace] = PARSER_MAPPING[parser]
    end

    def self.parse(doc)
      raise SepaFileParser::Errors::NotXMLError, doc.class unless doc.is_a? Nokogiri::XML::Document

      namespace = doc.namespaces['xmlns']
      doc.remove_namespaces!

      parser_class = @namespace_parsers[namespace]
      if parser_class == nil
        raise SepaFileParser::Errors::UnsupportedNamespaceError, namespace
      end

      return parser_class.new(doc.xpath('Document'))
    end
  end
end
