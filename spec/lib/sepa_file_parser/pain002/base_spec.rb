# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain002::Base do

  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain002/valid_example.xml') }

  context 'initialization' do
    after do
      SepaFileParser::File.parse('spec/fixtures/pain002/valid_example.xml')
    end

    specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }

    specify do
      expect(SepaFileParser::Pain002::Report).to receive(:new).and_call_original
    end
  end

  specify { expect(pain.group_header).not_to be_nil }
  specify { expect(pain.reports).not_to eq([]) }
  specify { expect(pain.xml_data).not_to be_nil }

  context 'with pain.002.001.10' do
    let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain002/valid_example_001.10.xml') }

    context 'initialization' do
      after do
        SepaFileParser::File.parse('spec/fixtures/pain002/valid_example_001.10.xml')
      end

      specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }

      specify do
        expect(SepaFileParser::Pain002::Report).to receive(:new).and_call_original
      end
    end

    specify { expect(pain.group_header).not_to be_nil }
    specify { expect(pain.reports).not_to eq([]) }
    specify { expect(pain.xml_data).not_to be_nil }
  end
end
