require 'rails_helper'

RSpec.describe Verticals::UpdateVertical do
  subject { described_class.new(vertical, ActionController::Parameters.new(params)).call }
  let_it_be(:vertical) { create(:vertical) }
  let(:params) do
    {
      vertical: {
        name: Faker::Name.first_name
      }
    }
  end

  describe '#call' do
    context 'with valid params' do
      it 'doesnt create new vertical' do
        expect { subject }.to change { Vertical.count }.by(0)
      end

      it 'updates vertical with correct attributes' do
        service = subject

        expect(service.success?).to eq true
        result = service.result
        expect(result).to be_a Vertical

        params[:vertical].each do |key, value|
          expect(result[key]).to eq value
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          vertical: {
            name: ''
          }
        }
      end

      it 'returns invalid record as error attribute' do
        service = subject

        expect(service.success?).to eq false
        expect(service.result).to eq nil
        expect(service.error).to be_a ModuleScaffold::Errors::ValidationError
      end
    end
  end
end
