# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain002::PaymentInformation do
  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain002/valid_example.xml') }

  let(:reports)   { pain.payment_information_and_status }
  let(:ex_report) { pain.payment_information_and_status[0] }

  specify { expect(reports).to all(be_kind_of(described_class)) }
  specify { expect(ex_report.original_identification).to eq('Payment-Information-ID-12345') }
  specify { expect(ex_report.status_id).to eq('Status-ID') }
  specify { expect(ex_report.transaction_status).to eq('RJCT') }

  specify { expect(pain.xml_data.nil?).to eq(false) }
end
