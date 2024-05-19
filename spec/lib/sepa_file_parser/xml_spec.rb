# frozen_string_literal: true

require 'spec_helper'

require 'securerandom'

RSpec.describe SepaFileParser::Xml do
  def parse_xml(file)
    File.open file do |f|
      Nokogiri::XML.parse f
    end
  end

  describe '.register' do
    let(:namespace) { SecureRandom.uuid } # get a unique namespace per test

    context 'when parser is not supported' do
      it 'raises SepaFileParser::Errors::NamespaceAlreadyRegistered' do
        expect {
          SepaFileParser::Xml.register(namespace, :unknown)
        }.to raise_exception(
          SepaFileParser::Errors::UnsupportedParserClass,
          'unknown'
        )
      end
    end

    SepaFileParser::Xml::PARSER_MAPPING.each do |parser_key, parser_class|
      context "when the parser is #{parser_key}" do
        context 'when the namespace is already registered' do
          it 'raises SepaFileParser::Errors::NamespaceAlreadyRegistered' do
            # should be ok
            SepaFileParser::Xml.register(namespace, parser_key)
            # raises an error
            expect {
              SepaFileParser::Xml.register(namespace, parser_key)
            }.to raise_exception(
              SepaFileParser::Errors::NamespaceAlreadyRegistered,
              namespace
            )
          end
        end

        context 'when the namespace is not registered' do
          it 'registers a parser for a namespace' do
            SepaFileParser::Xml.register(namespace, parser_key)

            expect(SepaFileParser::Xml.instance_variable_get(:'@namespace_parsers')[namespace])
              .to eq(parser_class)
          end
        end
      end
    end
  end

  describe '.parse' do
    it "raises an exception if it is not an XML" do
      expect {
        described_class.parse 'not_xml'
      }.to raise_exception(SepaFileParser::Errors::NotXMLError, String)
    end

    it "raises an exception if the namespace/format is unknown" do
      expect {
        described_class.parse parse_xml('spec/fixtures/general/invalid_namespace.xml')
      }.to raise_exception(
        SepaFileParser::Errors::UnsupportedNamespaceError,
        'urn:iso:std:iso:20022:tech:xsd:camt.053.001.03'
      )
    end

    it "does not raise an exception for a valid namespace" do
      expect(SepaFileParser::Camt052::Base).to receive(:new)
      described_class.parse parse_xml('spec/fixtures/camt052/valid_namespace.xml')
    end

    it "does not raise an exception for a valid namespace" do
      expect(SepaFileParser::Camt053::Base).to receive(:new)
      described_class.parse parse_xml('spec/fixtures/camt053/valid_namespace.xml')
    end
  end
end
