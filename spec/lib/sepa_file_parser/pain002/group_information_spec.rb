# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Pain002::GroupInformation do
  SepaFileParser::Xml.register('http://www.six-interbank-clearing.com/de/pain.002.001.03.ch.02.xsd', :pain002)
  let(:pain) { SepaFileParser::File.parse('spec/fixtures/pain002/valid_example_001.03.xml') }

  let(:reports)   { pain.group_information_and_status }
  let(:ex_report) { pain.group_information_and_status[0] }

  specify { expect(reports).to all(be_kind_of(described_class)) }

  specify { expect(ex_report.status).to eq('ACTC') }
  specify { expect(ex_report.message_id).to eq('bd381007c00627bb0e5adabd37fbb4') }
  specify { expect(pain.xml_data.nil?).to eq(false) }
end
