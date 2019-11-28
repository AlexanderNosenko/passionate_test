require 'rails_helper'

RSpec.describe ::CategoryPolicy, policy: true do
  subject { described_class.new(nil, category) }
  let(:resolved_scope) { described_class::Scope.new(nil, ::Category.all).resolve }
  let_it_be(:category) { create(:category) }
  let_it_be(:external_category) { create(:category) }

  it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }

  context 'scope' do
    it 'has access to own category' do
      expect(resolved_scope).to include(category)
    end

    xit 'doesnt have access other categories' do
      expect(resolved_scope).not_to include(external_category)
    end
  end

  specify do
    is_expected.to permit_mass_assignment_of(
      :name,
      :vertical_id,
      :state,
    )
  end

  context 'being not authorized' do
    xit { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
  end
end
