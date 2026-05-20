# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::BatchDetail do
  context 'camt052' do
    let(:camt)          { SepaFileParser::File.parse('spec/fixtures/camt052/valid_example_with_batch.xml') }
    let(:reports)       { camt.reports }
    let(:ex_rpt)        { reports[0] }
    let(:entries)       { ex_rpt.entries }
    let(:ex_entry)      { entries[0] }
    let(:batch_detail)  { ex_entry.batch_detail }

    specify { expect(batch_detail.total_amount).to eq BigDecimal('1500') }
    specify { expect(batch_detail.total_amount_in_cents).to eq(150000) }
    specify { expect(batch_detail.currency).to eq('EUR') }
    specify { expect(batch_detail.xml_data).to_not be_nil }
  end

  context 'camt053' do
    let(:camt) { SepaFileParser::File.parse('spec/fixtures/camt053/valid_example_with_batch.xml') }
    let(:statements)     { camt.statements }
    let(:ex_stmt)        { statements[0] }
    let(:entries)        { ex_stmt.entries }
    let(:ex_entry)       { entries[0] }
    let(:batch_detail)   { ex_entry.batch_detail }

    specify do
      expect(batch_detail.payment_information_identification).to eq('O0OpeAYTkhjerKu3eE9asw')
    end
    specify { expect(batch_detail.number_of_transactions).to eq('3') }
    specify { expect(batch_detail.msg_id).to eq('02453b1e17c11241073a777ad9c273b4149') }
    specify { expect(batch_detail.message_id).to eq('02453b1e17c11241073a777ad9c273b4149') }
    specify { expect(batch_detail.xml_data).to_not be_nil }
  end
end
