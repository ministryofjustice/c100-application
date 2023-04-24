# require 'rails_helper'

# RSpec.describe C100App::OpeningDecisionTree do
#   let(:anything)         { 'anything' }
#   let(:postcode)         { 'postcode' }
#   let(:start_or_continue) { 'new' }
#   let(:is_legal_representative) { 'yes' }
#   let(:has_myhmcts_account) { 'yes' }
#   let(:platform)         { 'my_hmcts' }
#   let(:local_court)      { {} }
#   let(:court_id)         { 'not-eligable-for-my-hmcts' }
#   let(:use_my_hmcts)     { 'no' }
#   let(:court)            { double(id: court_id) }
#   let(:c100_application) { double('Object',
#                             court: court,
#                             use_my_hmcts: use_my_hmcts,
#                             start_or_continue: start_or_continue,
#                             is_legal_representative: is_legal_representative,
#                             has_myhmcts_account: has_myhmcts_account,
#                             platform: platform
#                             ) }
#   let(:step_params)      { double('Step') }
#   let(:next_step)        { nil }
#   let(:as)               { nil }

#   subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

#   it_behaves_like 'a decision tree'

#   context 'when the step is `start_or_continue`' do
#     let(:step_params) { { start_or_continue: anything, children_postcode: postcode } }

#     context 'when starting a new application' do
#       let(:start_or_continue) { 'new' }

#       context 'when a legal representative' do
#         let(:is_legal_representative) { 'yes' }

#         context 'and no valid court is found' do
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(nil)
#           end
#           it { is_expected.to have_destination(:no_court_found, :show) }
#         end

#         context 'when the postcode checker raises an error' do
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).and_raise("expected exception for testing, please ignore")
#           end
#           it { is_expected.to have_destination(:error_but_continue, :show)}
#         end

#         context 'and one valid court is found' do  
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#             allow(c100_application).to receive(:update!)
#           end
    
#           context 'without MyHMCTS eligable court' do
#               it 'sends to sign_in_or_create_account page' do
#               expect(subject).to receive(:show_research_consent?)
#               expect(c100_application).to receive(:update!).with(court: court)
      
#               is_expected.to have_destination(:start, :show)
#             end
#           end
    
#           context 'with MyHMCTS eligable court' do
    
#             # N.b. Swansea is eligable for MyHMCTS
#             let(:court_id) { 'swansea-civil-justice-centre' }
    
#             it 'sends to consent_order page' do
#               expect(subject).to receive(:show_research_consent?)
#               expect(c100_application).to receive(:update!).with(court: court)
    
#               is_expected.to have_destination(:sign_in_or_create_account, :edit)
#             end
#           end

#         end
#       end

#       context 'when a citizen' do
#         let(:is_legal_representative) { 'no' }

#         context 'and no valid court is found' do
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(nil)
#           end
#           it { is_expected.to have_destination(:no_court_found, :show) }
#         end

#         context 'when the postcode checker raises an error' do
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).and_raise("expected exception for testing, please ignore")
#           end
#           it { is_expected.to have_destination(:error_but_continue, :show)}
#         end

#         context 'and one valid court is found' do  
#           before do
#             allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#             allow(c100_application).to receive(:update!)
#           end
    
#           context 'without MyHMCTS eligable court' do
#               it 'sends to sign_in_or_create_account page' do
#               expect(subject).to receive(:show_research_consent?)
#               expect(c100_application).to receive(:update!).with(court: court)
      
#               is_expected.to have_destination(:start, :show)
#             end
#           end
    
#           context 'with MyHMCTS eligable court' do
    
#             # N.b. Swansea is eligable for MyHMCTS
#             let(:court_id) { 'swansea-civil-justice-centre' }
    
#             it 'sends to consent_order page' do
#               expect(subject).to receive(:show_research_consent?)
#               expect(c100_application).to receive(:update!).with(court: court)
    
#               is_expected.to have_destination(:redirect_to_guidance, :show)
#             end
#           end
#         end

#       end

#     end

#     context 'when continuing an application' do
#       let(:start_or_continue) { 'continue' }

#       context 'and no valid court is found' do
#         before do
#           allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(nil)
#         end
#         it { is_expected.to have_destination(:no_court_found, :show) }
#       end

#       context 'when the postcode checker raises an error' do
#         before do
#           allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).and_raise("expected exception for testing, please ignore")
#         end
#         it { is_expected.to have_destination(:error_but_continue, :show)}
#       end

#       context 'and one valid court is found' do  
#         before do
#           allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#           allow(c100_application).to receive(:update!)
#         end
  
#         context 'without MyHMCTS eligable court' do
#           it 'sends to sign_in_or_create_account page' do
#             is_expected.to have_destination(:redirect_to_login, :show)
#           end
#         end
  
#         context 'with MyHMCTS eligable court' do
  
#           # N.b. Swansea is eligable for MyHMCTS
#           let(:court_id) { 'swansea-civil-justice-centre' }
  
#           before do
#             allow(c100_application).to receive(:update!).with(court: court)
#           end

#           context 'when a legal representative' do
#             let(:is_legal_representative) { 'yes' }
    
#             it { is_expected.to have_destination(:continue_application, :edit) }
#           end
    
#           context 'when a citizen' do
#             let(:is_legal_representative) { 'no' }
    
#             it { is_expected.to have_destination(:redirect_to_guidance, :show) }
#           end
#         end
#       end
#     end
#   end

#   context 'when the step is `sign_in_or_create_account`' do
#     let(:step_params) { { sign_in_or_create_account: anything } }
    
#     context 'when has_myhmcts_account is `yes`' do
#       let(:has_myhmcts_account) { 'yes' }

#       it { is_expected.to have_destination(:my_hmcts_manage_case, :show) }
#     end

#     context 'when has_myhmcts_account is `no`' do
#       let(:has_myhmcts_account) { 'no' }

#       it { is_expected.to have_destination(:my_hmcts_create_account, :show) }
#     end
#   end

#   context 'when the step is `sign_in_or_create_account`' do
#     let(:step_params) { { continue_application: anything } }
    
#     context 'when has_myhmcts_account is `yes`' do
#       let(:platform) { 'my_hmcts' }

#       it { is_expected.to have_destination(:my_hmcts_manage_case, :show) }
#     end

#     context 'when has_myhmcts_account is `no`' do
#       let(:platform) { 'gov_uk' }

#       it { is_expected.to have_destination(:redirect_to_login, :show) }
#     end
#   end

#   context 'research consent step' do
#     let(:step_params) { { start_or_continue: anything, children_postcode: postcode } }
#     before do
#       allow(c100_application).to receive(:created_at).and_return(Time.at(seconds))
#       allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#       allow(Rails.configuration.x.opening).to receive(:research_consent_weight).and_return(25)
#       allow(c100_application).to receive(:update!)
#     end

#     context 'the research consent step is shown to this user' do
#       let(:seconds) { 10 }
#       it { is_expected.to have_destination(:research_consent, :edit) }

#       context 'when the user is a citizen' do
#         let(:is_legal_representative) { 'no' }
#         it { is_expected.to have_destination(:research_consent, :edit) }
#       end
#     end

#     context 'the research consent step is not shown to this user' do
#       let(:seconds) { 30 }

#       context 'when the user is a legal representative' do
#         let(:is_legal_representative) { 'yes' }
#         context 'and the court is eligable for MyHMCTS' do
#           let(:court_id) { 'swansea-civil-justice-centre' }
#           it { is_expected.to have_destination(:sign_in_or_create_account, :edit) }
#         end

#         context 'and the court is not eligable for MyHMCTS' do
#           it { is_expected.to have_destination(:start, :show) }
#         end
#       end

#       context 'when the user is a citizen' do
#         let(:is_legal_representative) { 'no' }
#         context 'and the court is eligable for MyHMCTS' do
#           let(:court_id) { 'swansea-civil-justice-centre' }
#           it { is_expected.to have_destination(:redirect_to_guidance, :show) }
#         end

#         context 'and the court is not eligable for MyHMCTS' do
#           it { is_expected.to have_destination(:start, :show) }
#         end
#       end
#     end
#   end

#   context 'when the step is `research_consent`' do
#     let(:step_params) { { research_consent: anything } }

#     before do
#       allow(c100_application).to receive(:created_at).and_return(Time.at(1681289862))
#     end

#     context 'when the user is a legal representative' do  
#       before do
#         allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#         allow(c100_application).to receive(:update!)
#       end

#       context 'without MyHMCTS eligable court' do
#           it 'sends to sign_in_or_create_account page' do
#           is_expected.to have_destination(:start, :show)
#         end
#       end

#       context 'with MyHMCTS eligable court' do

#         # N.b. Swansea is eligable for MyHMCTS
#         let(:court_id) { 'swansea-civil-justice-centre' }

#         it 'sends to consent_order page' do
#           is_expected.to have_destination(:sign_in_or_create_account, :edit)
#         end
#       end

#     end

#     context 'when the user is a citizen' do
#       let(:is_legal_representative) { 'no' }

#       before do
#         allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:court_for).with(postcode).and_return(court)
#         allow(c100_application).to receive(:update!)
#       end

#       context 'without MyHMCTS eligable court' do
#           it 'sends to sign_in_or_create_account page' do
#           is_expected.to have_destination(:start, :show)
#         end
#       end

#       context 'with MyHMCTS eligable court' do

#         # N.b. Swansea is eligable for MyHMCTS
#         let(:court_id) { 'swansea-civil-justice-centre' }

#         it 'sends to consent_order page' do
#           is_expected.to have_destination(:redirect_to_guidance, :show)
#         end
#       end
#     end
#   end


#   context 'when the step is `consent_order`' do
#     let(:c100_application) { instance_double(C100Application, consent_order: value) }
#     let(:step_params) { { consent_order: 'anything' } }

#     context 'and the answer is `yes`' do
#       let(:value) { 'yes' }
#       it { is_expected.to have_destination(:consent_order_upload, :edit) }
#     end

#     context 'and the answer is `no`' do
#       let(:value) { 'no' }
#       it { is_expected.to have_destination(:child_protection_cases, :edit) }
#     end
#   end

#   context 'when the step is `consent_order_upload`' do
#     let(:c100_application) { 
#       instance_double(C100Application) }
#     let(:step_params) { { consent_order_upload: 'anything' } }

#     it { is_expected.to have_destination(:consent_order_sought, :show) }
#   end

#   context 'when the step is `child_protection_cases`' do
#     let(:c100_application) { instance_double(C100Application, child_protection_cases: value, consent_order: consent_value) }
#     let(:step_params) { { child_protection_cases: 'anything' } }

#     context 'when the answer to the consent order was `yes`' do
#       let(:consent_value) { 'yes' }

#       context 'and the answer is `yes`' do
#         let(:value) { 'yes' }
#         it { is_expected.to have_destination('/steps/safety_questions/start', :show) }
#       end

#       context 'and the answer is `no`' do
#         let(:value) { 'no' }
#         it { is_expected.to have_destination('/steps/safety_questions/start', :show) }
#       end
#     end

#     context 'when the answer to the consent order was `no`' do
#       let(:consent_value) { 'no' }

#       context 'and the answer is `yes`' do
#         let(:value) { 'yes' }
#         it { is_expected.to have_destination(:child_protection_info, :show) }
#       end

#       context 'and the answer is `no`' do
#         let(:value) { 'no' }
#         it { is_expected.to have_destination('/steps/miam/acknowledgement', :edit) }
#       end
#     end

#     context 'when there is no consent order value (behaves like `no`)' do
#       let(:consent_value) { nil }

#       context 'and the answer is `yes`' do
#         let(:value) { 'yes' }
#         it { is_expected.to have_destination(:child_protection_info, :show) }
#       end

#       context 'and the answer is `no`' do
#         let(:value) { 'no' }
#         it { is_expected.to have_destination('/steps/miam/acknowledgement', :edit) }
#       end
#     end
#   end
# end