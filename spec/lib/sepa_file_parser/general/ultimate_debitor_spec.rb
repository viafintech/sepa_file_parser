# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::UltimateDebitor do
  let(:camt)             { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_v8.xml') }
  let(:statements)       { camt.statements }
  let(:ex_stmt)          { statements[0] }
  let(:entries)          { ex_stmt.entries }
  let(:ex_entry)         { entries[0] }
  let(:transactions)     { ex_entry.transactions }
  let(:ex_transaction)   { transactions[0] }
  let(:ultimate_debitor) { ex_transaction.ultimate_debitor }

  specify { expect(ultimate_debitor.name).to eq("John Doe") }
  specify { expect(ultimate_debitor.xml_data).to_not be_nil }
end
