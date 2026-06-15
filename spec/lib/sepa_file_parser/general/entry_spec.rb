# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Entry do
  let(:camt)       { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }

  specify { expect(entries).to all(be_kind_of(described_class)) }

  context '#amount' do
    specify { expect(ex_entry.amount).to be_kind_of(BigDecimal) }
    specify { expect(ex_entry.amount).to eq(BigDecimal('2')) }
    specify { expect(ex_entry.amount_in_cents).to eq(200) }
  end

  specify { expect(ex_entry.currency).to eq('EUR') }
  specify { expect(ex_entry.value_date).to be_kind_of(Date) }
  specify { expect(ex_entry.value_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.booking_date).to be_kind_of(Date) }
  specify { expect(ex_entry.booking_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.additional_information).to eq('Überweisungs-Gutschrift; GVC: SEPA Credit Transfer (Einzelbuchung-Haben)') }
  specify { expect(ex_entry.description).to eq(ex_entry.additional_information) }
  specify { expect(ex_entry.debit).to eq(true) }
  specify { expect(ex_entry.debit?).to eq(ex_entry.debit) }
  specify { expect(ex_entry.credit?).to eq(false) }
  specify { expect(ex_entry.sign).to eq(-1) }
  specify { expect(ex_entry.transactions).to all(be_kind_of(SepaFileParser::Transaction)) }
  specify { expect(ex_entry.bank_reference).to eq('2013122710583450000') }
  specify { expect(ex_entry.reference).to eq('1234567890sdfghjk') }
  specify { expect(ex_entry.xml_data).to_not be_nil }

  context 'datetime' do
    let(:camt) { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_with_datetime.xml') }
    specify { expect(ex_entry.booking_datetime).to be_kind_of(DateTime) }
    specify { expect(ex_entry.booking_datetime).to eq(DateTime.new(2023, 06, 21, 12, 35, 33.115965)) }
    specify { expect(ex_entry.value_datetime).to eq(nil) }
  end

  context '#bank_transaction_code' do
    let(:camt)     { SepaFileParser::File.parse('spec/fixtures/camt052/valid_example_v8_2.xml') }
    let(:ex_rpt)   { camt.reports[0] }
    let(:entries)  { ex_rpt.entries }
    let(:ex_entry) { entries[0] }
    let(:bank_transaction_code) { ex_entry.bank_transaction_code }

    specify { expect(bank_transaction_code.domain_code).to eq('PMNT') }
    specify { expect(bank_transaction_code.family_code).to eq('ICDT') }
    specify { expect(bank_transaction_code.sub_family_code).to eq('SDVA') }
  end
end
