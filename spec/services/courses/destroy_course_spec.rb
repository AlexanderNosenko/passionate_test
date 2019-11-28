require 'rails_helper'

RSpec.describe ::Courses::DestroyCourse do
  subject { described_class.new(course).call }

  let_it_be(:course) { create(:course) }

  describe '#call' do
    it 'deletes course' do
      expect { subject }.to change { ::Course.count }.by(-1)
    end
  end
end
