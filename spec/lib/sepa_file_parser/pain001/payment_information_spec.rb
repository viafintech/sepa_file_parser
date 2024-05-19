# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain001::PaymentInformation do
  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain001/valid_example.xml') }

  let(:payment_informations) { pain.payment_informations }
  let(:ex_pmt_inf)  { pain.payment_informations[0] }
  let(:entry)  { ex_pmt_inf.entries[0] }

  specify { expect(payment_informations).to all(be_kind_of(described_class)) }
  specify { expect(ex_pmt_inf.identification).to eq("Payment-Information-ID-12345") }
  specify { expect(ex_pmt_inf.requested_execution_date).to be_kind_of(Time) }
  specify { expect(ex_pmt_inf.account).to be_kind_of(SepaFileParser::Account) }
  specify { expect(ex_pmt_inf.account.currency).to eq('EUR') }
  specify { expect(ex_pmt_inf.entries).to be_kind_of(Array) }

  specify { expect(entry.amount).to eq(BigDecimal('9876.54')) }
  specify { expect(entry.amount_in_cents).to eq(987654) }
  specify { expect(entry.currency).to eq('EUR') }
  specify { expect(entry.account).to be_kind_of(SepaFileParser::Account) }
  specify { expect(entry.account.currency).to eq('EUR') }
  specify { expect(entry.remittance_information).to eq('Unstructured Remittance Information') }

  specify { expect(pain.xml_data).to_not be_nil }
end
