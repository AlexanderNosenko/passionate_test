require 'rails_helper'

RSpec.describe Category, type: :model do
  let_it_be(:vertical) { Vertical.last }
  let(:params) do
    {
      name: 'unique_name',
      vertical: vertical
    }
  end

  subject { described_class.create(params) }

  context 'when no duplicate exists' do
    it {  expect(subject.persisted?).to eq true }
  end

  context 'when record already exists' do
    before { create(:vertical, name: 'unique_name') }

    it { expect(subject.persisted?).to eq false }
  end
end
