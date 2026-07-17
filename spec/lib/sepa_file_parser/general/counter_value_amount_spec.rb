# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::CounterValueAmount do
  describe '#owner' do
    let(:camt)           { SepaFileParser::File.parse('spec/fixtures/camt052/valid_example_exchange_currency.xml') }
    let(:reports)        { camt.reports }
    let(:ex_rpt)         { camt.reports[0] }
    let(:entry)          { ex_rpt.entries[0] }

    # A sum of 350 EUR was transferred, and the bank converted this amount into 318.91 CHF at an exchange rate of 0.91116

    specify { expect(entry.counter_value_amount).to be_kind_of(SepaFileParser::CounterValueAmount) }
    specify { expect(entry.transactions.first.amount).to eq(350.00) }
    specify { expect(entry.transactions.first.currency).to eq('EUR') }
    specify { expect(entry.amount).to eq(318.91) }
    specify { expect(entry.currency).to eq('CHF') }
    specify { expect(entry.counter_value_amount.amount).to eq(318.91) }
    specify { expect(entry.counter_value_amount.exchange_rate).to eq(0.91116) }
    specify { expect(entry.counter_value_amount.source_currency).to eq('EUR') }
    specify { expect(entry.counter_value_amount.target_currency).to eq('CHF') }
  end
end
