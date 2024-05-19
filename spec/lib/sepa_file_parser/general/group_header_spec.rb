# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::GroupHeader do
  let(:camt) { SepaFileParser::File.parse 'spec/fixtures/camt053/valid_example.xml' }
  let(:group_header) { camt.group_header }

  specify { expect(group_header).to be_kind_of(described_class) }
  specify { expect(group_header.message_id).to eq("053D2013-12-27T22:05:03.0N130000005") }
  specify { expect(group_header.creation_date_time).to be_kind_of(Time) }
  specify { expect(group_header.message_pagination).to be_kind_of(SepaFileParser::MessagePagination) }
  specify { expect(group_header.additional_information).to eq("") }
  specify { expect(group_header.xml_data).to_not be_nil }
end

RSpec.describe SepaFileParser::MessagePagination do
  let(:camt) { SepaFileParser::File.parse 'spec/fixtures/camt053/valid_example.xml' }
  let(:message_pagination) { camt.group_header.message_pagination }

  specify { expect(message_pagination).to be_kind_of(described_class) }
  specify { expect(message_pagination.page_number).to eq(1) }
  specify { expect(message_pagination.last_page?).to be_truthy }
  specify { expect(message_pagination.xml_data).to_not be_nil }
end
