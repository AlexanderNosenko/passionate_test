require 'rails_helper'

RSpec.describe ::Verticals::CreateVertical do
  subject { described_class.new(ActionController::Parameters.new(params)).call }
  let(:params) do
    {
      vertical: attributes_for(:vertical)
    }
  end

  describe '#call' do
    context 'notifications' do
      it_should_behave_like 'emailable', record_class: Vertical
    end

    context 'with valid params' do
      it 'creates vertical' do
        expect { subject }.to change { ::Vertical.count }.by(1)
      end

      it 'creates vertical with correct attributes' do
        service = subject

        expect(service.success?).to eq true
        result = service.result
        expect(result).to be_a ::Vertical

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

      it 'doesnt create vertical' do
        expect { subject }.to change { ::Vertical.count }.by(0)
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
