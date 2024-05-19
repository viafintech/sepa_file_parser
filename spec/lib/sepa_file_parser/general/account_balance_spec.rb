# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::AccountBalance do
  let(:camt)       { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  subject { ex_stmt.opening_balance }

  specify { expect(subject.currency).to eq "EUR" }
  specify { expect(subject.date).to eq Date.new(2013, 12, 27) }
  specify { expect(subject.sign).to eq 1 }
  specify { expect(subject.credit?).to be_truthy }
  specify { expect(subject.amount).to eq BigDecimal("33.06") }
  specify { expect(subject.amount_in_cents).to eq(3306) }
  specify { expect(subject.signed_amount).to eq BigDecimal("33.06") }
  specify { expect(subject.to_h).to eq({
    'amount'          => BigDecimal('33.06'),
    'amount_in_cents' => 3306,
    'sign'            => 1
  }) }

  context 'debit' do
    let(:camt)       { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_with_debit.xml') }
    let(:statements) { camt.statements }
    let(:ex_stmt)    { camt.statements[0] }
    subject { ex_stmt.opening_balance }

    specify { expect(subject.currency).to eq "EUR" }
    specify { expect(subject.date).to eq Date.new(2013, 12, 27) }
    specify { expect(subject.sign).to eq -1 }
    specify { expect(subject.credit?).to be_falsey }
    specify { expect(subject.amount).to eq BigDecimal("33.06") }
    specify { expect(subject.amount_in_cents).to eq(3306) }
    specify { expect(subject.signed_amount).to eq BigDecimal("-33.06") }
    specify { expect(subject.to_h).to eq({
                                           'amount'          => BigDecimal('33.06'),
                                           'amount_in_cents' => 3306,
                                           'sign'            => -1
                                         }) }
  end
end
