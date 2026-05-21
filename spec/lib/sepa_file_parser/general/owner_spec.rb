# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Owner do

  describe '#owner' do
    let(:camt)           { SepaFileParser::File.parse('spec/fixtures/camt052/valid_example_v8_2.xml') }
    let(:reports)        { camt.reports }
    let(:ex_rpt)         { camt.reports[0] }

    specify { expect(ex_rpt.account.owner).to be_kind_of(SepaFileParser::Owner) }
    specify { expect(ex_rpt.account.owner.name).to eq('Testbank-Inhaber') }
  end

end
