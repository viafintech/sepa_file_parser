# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Camt052::Base do

  context 'initialization' do
    after do
      SepaFileParser::File.parse 'spec/fixtures/camt052/valid_example.xml'
    end

    specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
    specify { expect(SepaFileParser::Camt052::Report).to receive(:new).and_call_original }
  end

  let(:camt) { SepaFileParser::File.parse 'spec/fixtures/camt052/valid_example.xml' }
  specify { expect(camt.group_header).to_not be_nil }
  specify { expect(camt.reports).to_not eq([]) }
  specify { expect(camt.xml_data).to_not be_nil }

end
