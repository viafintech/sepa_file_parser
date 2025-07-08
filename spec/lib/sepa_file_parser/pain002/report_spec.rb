# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain002::Report do
  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain002/valid_example.xml') }

  let(:reports)   { pain.reports }
  let(:ex_report) { pain.reports[0] }
  let(:entry)     { ex_report.entries[0] }

  specify { expect(reports).to all(be_kind_of(described_class)) }
  specify { expect(ex_report.original_identification).to eq('Payment-Information-ID-12345') }
  specify { expect(ex_report.status_id).to eq('Status-ID') }
  specify { expect(ex_report.transaction_status).to eq('RJCT') }

  specify { expect(pain.xml_data.nil?).to eq(false) }
end
