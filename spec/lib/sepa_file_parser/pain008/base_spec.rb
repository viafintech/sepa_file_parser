# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain008::Base do

  context 'version 2' do
    context 'initialization' do
      after do
        SepaFileParser::File.parse 'spec/fixtures/pain008/valid_example.xml'
      end

      specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
      specify do
        expect(SepaFileParser::Pain008::PaymentInformation).to receive(:new).and_call_original
      end
    end

    let(:pain) { SepaFileParser::File.parse 'spec/fixtures/pain008/valid_example.xml' }
    specify { expect(pain.group_header).to_not be_nil }
    specify { expect(pain.payment_informations).to_not eq([]) }
    specify { expect(pain.xml_data).to_not be_nil }
  end

  context 'version 8' do
    context 'initialization' do
      after do
        SepaFileParser::File.parse 'spec/fixtures/pain008/valid_example_v8.xml'
      end

      specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
      specify do
        expect(SepaFileParser::Pain008::PaymentInformation).to receive(:new).and_call_original
      end
    end

    let(:pain) { SepaFileParser::File.parse 'spec/fixtures/pain008/valid_example_v8.xml' }
    specify { expect(pain.group_header).to_not be_nil }
    specify { expect(pain.payment_informations).to_not eq([]) }
    specify { expect(pain.xml_data).to_not be_nil }
  end

end
