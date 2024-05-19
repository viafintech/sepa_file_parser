# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain001::Base do

  context 'initialization' do
    after do
      SepaFileParser::File.parse 'spec/fixtures/pain001/valid_example.xml'
    end

    specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
    specify do
      expect(SepaFileParser::Pain001::PaymentInformation).to receive(:new).and_call_original
    end
  end

  let(:pain) { SepaFileParser::File.parse 'spec/fixtures/pain001/valid_example.xml' }
  specify { expect(pain.group_header).to_not be_nil }
  specify { expect(pain.payment_informations).to_not eq([]) }
  specify { expect(pain.xml_data).to_not be_nil }

end
