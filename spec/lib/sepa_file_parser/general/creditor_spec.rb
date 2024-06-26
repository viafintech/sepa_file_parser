# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Creditor do
  let(:camt)           { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }
  let(:creditor)       { ex_transaction.creditor }

  specify { expect(creditor.name).to eq("Testkonto Nummer 2") }
  specify { expect(creditor.iban).to eq("DE09300606010012345671") }
  specify { expect(creditor.bic).to eq("DAAEDEDDXXX") }
  specify { expect(creditor.bank_name).to eq("Bank") }
  specify { expect(creditor.xml_data).to_not be_nil }

  context "version 8" do
    let(:camt)     { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_v8.xml') }
    let(:ex_entry) { entries[2] }

    specify { expect(creditor.name).to eq("DHL Express (Schweiz) AG") }
    specify { expect(creditor.bic).to eq("UBSWCHZH80A") }
  end

  context "with address" do
    let(:camt) { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_with_debit.xml') }

    specify { expect(creditor.name).to eq("Testkonto Nummer 2") }
    specify { expect(creditor.postal_address.lines).to eq(["Berlin", "Infinite Loop 2", "12345"]) }
  end
end
