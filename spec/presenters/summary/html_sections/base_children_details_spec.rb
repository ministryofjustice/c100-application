require 'rails_helper'

describe Summary::HtmlSections::BaseChildrenDetails do
  let(:c100_application) { instance_double(C100Application, {}) }
  subject { described_class.new(c100_application) }

  describe '#child_names_method' do
    context 'given a Child' do
      let(:arg) { Child.new }

      it 'returns :edit_steps_children_names_path' do
        expect(subject.send(:child_names_method, arg)).to eq(
          :edit_steps_children_names_path)
      end
    end

    context 'given an OtherChild' do
      let(:arg) { OtherChild.new }

      it 'returns :edit_steps_other_children_names_path' do
        expect(subject.send(:child_names_method, arg)).to eq(
          :edit_steps_other_children_names_path)
      end
    end
  end

  describe '#child_personal_details_method' do
    context 'given a Child' do
      let(:arg) { Child.new }

      it 'returns :edit_steps_children_personal_details_path' do
        expect(subject.send(:child_personal_details_method, arg)).to eq(
          :edit_steps_children_personal_details_path)
      end
    end

    context 'given an OtherChild' do
      let(:arg) { OtherChild.new }

      it 'returns :edit_steps_other_children_personal_details_path' do
        expect(subject.send(:child_personal_details_method, arg)).to eq(
          :edit_steps_other_children_personal_details_path)
      end
    end
  end

  describe '#child_personal_details_form_stub' do
    context 'given a Child' do
      let(:arg) { Child.new }

      it 'returns steps_children_personal_details_form_' do
        expect(subject.send(:child_personal_details_form_stub, arg)).to eq(
          'steps_children_personal_details_form_')
      end
    end

    context 'given an OtherChild' do
      let(:arg) { OtherChild.new }

      it 'returns steps_other_children_personal_details_form_' do
        expect(subject.send(:child_personal_details_form_stub, arg)).to eq(
          'steps_other_children_personal_details_form_')
      end
    end
  end
end
