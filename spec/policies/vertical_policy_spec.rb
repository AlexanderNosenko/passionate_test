require 'rails_helper'

RSpec.describe ::VerticalPolicy, policy: true do
  subject { described_class.new(nil, vertical) }
  let(:resolved_scope) { described_class::Scope.new(nil, ::Vertical.all).resolve }
  let_it_be(:vertical) { create(:vertical) }
  let_it_be(:external_vertical) { create(:vertical) }

  it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }

  context 'scope' do
    it 'has access to own vertical' do
      expect(resolved_scope).to include(vertical)
    end

    xit 'doesnt have access other verticals' do
      expect(resolved_scope).not_to include(external_vertical)
    end
  end

  specify do
    is_expected.to permit_mass_assignment_of(
      :name
    )
  end

  context 'being not authorized' do
    xit { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
  end
end
