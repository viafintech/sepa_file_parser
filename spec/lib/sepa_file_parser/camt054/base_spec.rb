# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Camt054::Base do
  context 'initialization' do
    after do
      SepaFileParser::File.parse 'spec/fixtures/camt054/valid_example.xml'
    end

    specify { expect(SepaFileParser::GroupHeader).to receive(:new).and_call_original }
    specify { expect(SepaFileParser::Camt054::Notification).to receive(:new).and_call_original }
  end

  let(:camt) { SepaFileParser::File.parse 'spec/fixtures/camt054/valid_example.xml' }
  specify { expect(camt.group_header).to_not be_nil }
  specify { expect(camt.notifications).to_not eq([]) }
  specify { expect(camt.xml_data).to_not be_nil }

end
