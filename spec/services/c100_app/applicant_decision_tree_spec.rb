require 'rails_helper'

RSpec.describe C100App::ApplicantDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }

  subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

  it_behaves_like 'a decision tree'

  context 'when the step is `user_type`' do
    let(:step_params) {{'user_type' => 'anything'}}

    context 'and the user is a themself' do
      let(:c100_application) {instance_double(C100Application, user_type: UserType::THEMSELF)}
      it {is_expected.to have_destination(:number_of_children, :edit)}
    end

    context 'and the user is a representative' do
      let(:c100_application) {instance_double(C100Application, user_type: UserType::REPRESENTATIVE)}
      it {is_expected.to have_destination(:number_of_children, :edit)}
    end
  end

  context 'when the step is `number_of_children`' do
    let(:step_params) {{'number_of_children' => 'anything'}}
    let(:c100_application) {instance_double(C100Application, number_of_children: 1)}

    it {is_expected.to have_destination('/steps/help_with_fees/help_paying', :edit)}
  end

  context 'when the step is `personal_details`' do
    let(:step_params) {{'personal_details' => 'anything'}}
    let(:c100_application) {instance_double(C100Application)}

    it {is_expected.to have_destination(:personal_details, :edit)}
  end

  context 'when the step is `add_another_applicant`' do
    let(:step_params) {{'add_another_applicant' => 'anything'}}
    let(:c100_application) {instance_double(C100Application)}

    it {is_expected.to have_destination(:personal_details, :edit)}
  end

  context 'when the step is `applicants_finished`' do
    let(:step_params) {{'applicants_finished' => 'anything'}}
    let(:c100_application) {instance_double(C100Application)}

    it {is_expected.to have_destination('/steps/respondent/personal_details', :edit)}
  end
end
