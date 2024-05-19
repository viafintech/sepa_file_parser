# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::File do
  context "parse" do
    it "raises an exception if the namespace/format is unknown" do
      expect{
        described_class.parse 'spec/fixtures/general/invalid_namespace.xml'
      }.to raise_exception(SepaFileParser::Errors::UnsupportedNamespaceError, 'urn:iso:std:iso:20022:tech:xsd:camt.053.001.03')
    end

    it "does not raise an exception for a valid 052 namespace" do
      expect(SepaFileParser::Camt052::Base).to receive(:new)
      described_class.parse 'spec/fixtures/camt052/valid_namespace.xml'
    end

    it "does not raise an exception for a valid 053 namespace" do
      expect(SepaFileParser::Camt053::Base).to receive(:new)
      described_class.parse 'spec/fixtures/camt053/valid_namespace.xml'
    end
  end
end
