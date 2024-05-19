# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Camt054::Notification do
  let(:camt)          { SepaFileParser::File.parse('spec/fixtures/camt054/valid_example.xml') }
  let(:notifications) { camt.notifications }
  let(:ex_ntfcn)      { camt.notifications[0] }

  specify { expect(notifications).to all(be_kind_of(described_class)) }
  specify { expect(ex_ntfcn.identification).to eq("20160410375204000131032") }
  specify { expect(ex_ntfcn.generation_date).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.from_date_time).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.to_date_time).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.account).to be_kind_of(SepaFileParser::Account) }
  specify { expect(ex_ntfcn.entries).to be_kind_of(Array) }
  specify { expect(ex_ntfcn.xml_data).to_not be_nil }

end
