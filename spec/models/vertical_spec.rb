require 'rails_helper'

RSpec.describe Vertical, type: :model do
  let(:params) do
    {
      name: 'unique_name'
    }
  end

  subject { described_class.create(params) }

  context 'when no duplicate exists' do
    it {  expect(subject.persisted?).to eq true }
  end

  context 'when record already exists' do
    before { create(:category, name: 'unique_name') }

    it { expect(subject.persisted?).to eq false }
  end
end
