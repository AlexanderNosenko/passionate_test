require 'rails_helper'

RSpec.describe ::Categories::DestroyCategory do
  subject { described_class.new(category).call }

  let_it_be(:category) { create(:category) }

  describe '#call' do
    it 'deletes category' do
      expect { subject }.to change { ::Category.count }.by(-1)
    end
  end
end
