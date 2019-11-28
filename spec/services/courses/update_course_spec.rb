require 'rails_helper'

RSpec.describe Courses::UpdateCourse do
  subject { described_class.new(course, ActionController::Parameters.new(params)).call }
  let_it_be(:category) { create(:category) }
  let(:category_id) { category.id }
  let_it_be(:course) { create(:course) }
  let_it_be(:course_id) { course.id }

  let(:params) do
    {
      course: {
        name: Faker::Name.name,
        author: Faker::Name.name,
        category_id: category_id,
        state: 'active'
      }
    }
  end

  describe '#call' do
    context 'with valid params' do
      it 'doesnt create new course' do
        expect { subject }.to change { Course.count }.by(0)
      end

      it 'updates course with correct attributes' do
        service = subject

        expect(service.success?).to eq true
        result = service.result
        expect(result).to be_a Course

        params[:course].each do |key, value|
          expect(result[key]).to eq value
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          course: {
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
