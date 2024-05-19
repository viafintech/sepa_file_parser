# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::PainEntry do
  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain001/valid_example.xml') }

  let(:payment_informations) { pain.payment_informations }
  let(:ex_pmt_inf) { pain.payment_informations[0] }
  let(:entries)    { ex_pmt_inf.entries }
  let(:ex_entry)   { ex_pmt_inf.entries[0] }

  specify { expect(entries).to all(be_kind_of(described_class)) }

  context '#amount' do
    specify { expect(ex_entry.amount).to be_kind_of(BigDecimal) }
    specify { expect(ex_entry.amount).to eq(BigDecimal('9876.54')) }
    specify { expect(ex_entry.amount_in_cents).to eq(987654) }
  end

  specify { expect(ex_entry.currency).to eq('EUR') }
  specify { expect(ex_entry.remittance_information).to eq('Unstructured Remittance Information') }
  specify { expect(ex_entry.account).to be_kind_of(SepaFileParser::Account) }
  specify { expect(ex_entry.account.currency).to eq('EUR') }
  specify { expect(ex_entry.account.bank_name).to eq('Creditor Name') }
  specify { expect(ex_entry.xml_data).to_not be_nil }

end
