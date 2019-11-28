require 'rails_helper'

RSpec.describe ::CoursePolicy, policy: true do
  subject { described_class.new(nil, course) }
  let(:resolved_scope) { described_class::Scope.new(nil, ::Course.all).resolve }
  let_it_be(:course) { create(:course) }
  let_it_be(:external_course) { create(:course) }

  it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }

  context 'scope' do
    it 'has access to own course' do
      expect(resolved_scope).to include(course)
    end

    xit 'doesnt have access other courses' do
      expect(resolved_scope).not_to include(external_course)
    end
  end

  specify do
    is_expected.to permit_mass_assignment_of(
      :name,
      :author,
      :category_id,
      :state
    )
  end

  context 'being not authorized' do
    xit { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
  end
end
