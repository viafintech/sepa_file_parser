# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain002::Base do

  context 'initialization' do
    after do
      SepaFileParser::File.parse 'spec/fixtures/pain002/valid_example.xml'
    end

    specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
    specify do
      expect(SepaFileParser::Pain002::Report).to receive(:new).and_call_original
    end
  end

  let(:pain) { SepaFileParser::File.parse 'spec/fixtures/pain002/valid_example.xml' }
  specify { expect(pain.group_header).to_not be_nil }
  specify { expect(pain.reports).to_not eq([]) }
  specify { expect(pain.xml_data).to_not be_nil }

end
