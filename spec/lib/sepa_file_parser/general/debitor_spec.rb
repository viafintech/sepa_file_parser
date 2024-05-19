# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Debitor do
  let(:camt)           { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }
  let(:debitor)        { ex_transaction.debitor }

  specify { expect(debitor.name).to eq("Wayne Enterprises") }
  specify { expect(debitor.iban).to eq("DE24302201900609832118") }
  specify { expect(debitor.bic).to eq("DAAEDEDDXXX") }
  specify { expect(debitor.bank_name).to eq("") }
  specify { expect(debitor.xml_data).to_not be_nil }

  context "version 8" do
    let(:camt) { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_v8.xml') }

    specify { expect(debitor.name).to eq("Jon Doe") }
    specify { expect(debitor.bic).to eq("UBSWCHZH80A") }
  end

  context "with address" do
    let(:camt) { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_v8.xml') }

    specify { expect(debitor.name).to eq("Jon Doe") }
    specify { expect(debitor.postal_address.lines).to eq(["Hofstrasse 2", "CH-8000 Zürich"]) }
  end
end
