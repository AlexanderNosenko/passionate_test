require 'rails_helper'

RSpec.describe ::CourseSerializer, type: :serializer do
  subject { described_class.new(resource).serializable_hash[:data] }
  let_it_be(:resource) { build_stubbed(:course) }

  describe 'serialized_json' do
    it 'returns correct id' do
      expect(subject[:id]).to eq resource.id.to_s
    end

    it 'returns correct type' do
      expect_correct_type(:course)
    end

    it 'returns correct attributes' do
      expect_correct_attributes([
        :name,
        :author,
        :state
      ])
    end

    it 'returns none relationships' do
      expect_correct_relationships([
        :category
      ])
    end
  end
end
