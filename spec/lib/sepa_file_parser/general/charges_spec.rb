# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Charges do
  let(:camt)       { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_v4.xml') }
  let(:entries)  { camt.statements.first.entries }
  let(:ex_charges) { entries[6].charges }

  specify { expect(entries.map(&:charges)).to all(be_kind_of(described_class)) }
  specify { expect(ex_charges.total_charges_and_tax_amount).to eq(BigDecimal('5.2')) }
  specify { expect(ex_charges.xml_data).to_not be_nil }
end
