require 'rails_helper'

RSpec.describe ::VerticalSerializer, type: :serializer do
  subject { described_class.new(resource).serializable_hash[:data] }
  let_it_be(:resource) { build_stubbed(:vertical) }

  describe 'serialized_json' do
    it 'returns correct id' do
      expect(subject[:id]).to eq resource.id.to_s
    end

    it 'returns correct type' do
      expect_correct_type(:vertical)
    end

    it 'returns correct attributes' do
      expect_correct_attributes([
        :name
      ])
    end

    it 'returns none relationships' do
      expect_correct_relationships(nil)
    end
  end
end
