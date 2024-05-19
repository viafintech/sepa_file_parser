# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SepaFileParser::Account do

  let(:iban) do
    'DE14740618130000033626'
  end

  let(:other_id) do
    'ABCDE1234'
  end

  let(:bic) do
    'GENODEF1PFK'
  end

  let(:bank_name) do
    'VR-Bank Rottal-Inn eG'
  end

  let(:currency) do
    'EUR'
  end

  let(:account) do
    described_class.new(
      iban:      iban,
      other_id:  other_id,
      bic:       bic,
      bank_name: bank_name,
      currency:  currency,
    )
  end

  describe '#iban' do
    specify { expect(account.iban).to eq(iban) }
  end

  describe '#other_id' do
    specify { expect(account.other_id).to eq(other_id) }
  end

  describe '#account_number' do
    context 'when the iban is set' do
      specify { expect(account.account_number).to eq(iban) }
    end

    context 'when the iban is not set' do
      let(:iban) do
        nil
      end

      specify { expect(account.account_number).to eq(other_id) }
    end
  end

  describe '#bic' do
    specify { expect(account.bic).to eq(bic) }
  end

  describe '#bank_name' do
    specify { expect(account.bank_name).to eq(bank_name) }
  end

  describe '#currency' do
    specify { expect(account.currency).to eq(currency) }
  end

end
