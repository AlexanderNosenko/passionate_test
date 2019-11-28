require 'rails_helper'

RSpec.describe ::Verticals::DestroyVertical do
  subject { described_class.new(vertical).call }

  let_it_be(:vertical) { create(:vertical) }

  describe '#call' do
    it 'deletes vertical' do
      expect { subject }.to change { ::Vertical.count }.by(-1)
    end
  end
end
