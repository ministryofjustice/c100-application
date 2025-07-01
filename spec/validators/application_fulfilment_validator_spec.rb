require 'rails_helper'

module Test
  C100ApplicationValidatable = Struct.new(:children,
    :applicants,
    :respondents,
    :payment_type,
    :submission_type,
    :has_petition_orders,
    :attach_evidence,
    :consent_order,
    :miam_exemption,
    :miam_exemption_claim,
    keyword_init: true
  ) do
    include ActiveModel::Validations
    validates_with ApplicationFulfilmentValidator
    def document(document_key)
      uploaded_doc = [:miam_certificate, :draft_consent_order]
      uploaded_doc.include?(document_key)
    end

    def has_petition_orders?
      has_petition_orders
    end

  end
end

RSpec.describe ApplicationFulfilmentValidator, type: :model do
  subject { Test::C100ApplicationValidatable.new(arguments) }

  let(:arguments) do
    {
      children: children,
      applicants: applicants,
      respondents: respondents,
      payment_type: payment_type,
      submission_type: submission_type,
      has_petition_orders: has_petition_orders,
      consent_order: consent_order,
      attach_evidence: attach_evidence,
      miam_exemption_claim: miam_exemption_claim
    }
  end

  let(:children)    { [Object] }
  let(:applicants)  { [Object] }
  let(:respondents) { [Object] }
  let(:has_petition_orders) { true }
  let(:attach_evidence) { 'yes' }
  let(:consent_order) { 'no' }
  let(:miam_exemption_claim) { 'no' }

  let(:submission_type) { 'submission_type' }
  let(:payment_type)    { 'payment_type' }

  let(:record) { double('record') }

  let(:validator) { described_class.new }

  before do
    allow(record).to receive(:miam_exemption)
    allow(record.miam_exemption).to receive(:misc).and_return(['misc_test'])
    allow(record).to receive(:document).and_return(nil)
  end

  context 'individual validations' do
    context 'payment_type' do
      context 'when there is a payment type' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:payment_type)).to eq(false)
        end
      end

      context 'when payment type is missing' do
        let(:payment_type) { nil }

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.details[:payment_type][0][:error]).to eq(:blank)
          expect(subject.errors.details[:payment_type][0][:change_path]).to eq('/steps/application/payment')
        end
      end
    end

    context 'submission_type' do
      context 'when there is a submission type' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:submission_type)).to eq(false)
        end
      end
    end

    context 'children' do
      context 'there is at least one child' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:children)).to eq(false)
        end
      end

      context 'there are no children' do
        let(:children) { [] }

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.details[:children][0][:error]).to eq(:blank)
          expect(subject.errors.details[:children][0][:change_path]).to eq('/steps/children/names/')
        end
      end
    end

    context 'applicants' do
      context 'there is at least one applicant' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:applicants)).to eq(false)
        end
      end

      context 'there are no applicants' do
        let(:applicants) { [] }

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.details[:applicants][0][:error]).to eq(:blank)
          expect(subject.errors.details[:applicants][0][:change_path]).to eq('/steps/applicant/names/')
        end
      end
    end

    context 'respondents' do
      context 'there is at least one respondent' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:respondents)).to eq(false)
        end
      end

      context 'there are no respondents' do
        let(:respondents) { [] }

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.details[:respondents][0][:error]).to eq(:blank)
          expect(subject.errors.details[:respondents][0][:change_path]).to eq('/steps/respondent/names/')
        end
      end
    end

    context 'orders' do
      context 'when there are petition orders' do
        let(:has_petition_orders) { true } # Set to true for this test case

        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:orders)).to eq(false)
        end
      end

      context 'when there are no petition orders' do
        let(:has_petition_orders) { false } # Set to false for this test case

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.details[:orders][0][:error]).to eq(:blank)
          expect(subject.errors.details[:orders][0][:change_path]).to eq('/steps/petition/orders')
        end
      end
    end

    context 'attach_evidence' do
      context 'an option to attach evidence is selected' do
        it 'is valid' do
          subject.valid?
          expect(subject.errors.details.include?(:attach_evidence)).to eq(false)
        end
      end

      # context 'option for attach evidence is not selected' do
      #   let(:attach_evidence) { nil }
      #
      #   it 'is invalid' do
      #     subject.valid?
      #     expect(subject).not_to be_valid
      #     expect(subject.errors.details[:attach_evidence][0][:error]).to eq(:blank)
      #     expect(subject.errors.details[:attach_evidence][0][:change_path]).to eq('/steps/miam_exemptions/exemption_reasons')
      #   end
      # end
    end

  end

  describe '#has_other_skip_exemptions?' do
    let(:miam_exemption) { double('miam_exemption') }
    let(:miam_exemption_claim) { 'yes' }

    context 'when miam_exemption is nil' do
      before { allow(record).to receive(:miam_exemption).and_return(nil) }

      it 'returns false' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be false
      end
    end

    context 'when miam_exemption.misc is nil' do
      before { allow(miam_exemption).to receive(:misc).and_return(nil) }

      it 'returns false' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be false
      end
    end

    context 'when domestic exemptions are not excluded' do
      before do
        allow(record).to receive(:miam_exemption).and_return(miam_exemption)
        allow(miam_exemption).to receive(:misc).and_return(['misc_test'])
        allow(miam_exemption).to receive(:domestic).and_return(['misc_domestic_test'])
        allow(validator).to receive(:other_group_check).with(record).and_return(false)
      end

      it 'returns false' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be false
      end
    end

    context 'when specific misc exemptions are present and other_group_check passes' do
      before do
        allow(record).to receive(:miam_exemption).and_return(miam_exemption)
        allow(miam_exemption).to receive(:misc).and_return(['misc_without_notice'])
        allow(miam_exemption).to receive(:domestic).and_return(['misc_domestic_none'])
        allow(validator).to receive(:other_group_check).with(record).and_return(true)
      end

      it 'returns false' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be false
      end
    end

    context 'when specific misc exemptions are present and other_group_check fails' do
      before do
        allow(record).to receive(:miam_exemption).and_return(miam_exemption)
        allow(miam_exemption).to receive(:misc).and_return(['misc_without_notice'])
        allow(miam_exemption).to receive(:domestic).and_return(['misc_domestic_none'])
        allow(validator).to receive(:other_group_check).with(record).and_return(false)
      end

      it 'returns true' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be true
      end
    end

    context 'when all conditions for false are skipped and method returns true' do
      before do
        allow(record).to receive(:miam_exemption).and_return(miam_exemption)
        allow(miam_exemption).to receive(:misc).and_return(['misc_other'])
        allow(miam_exemption).to receive(:domestic).and_return(['misc_domestic_none'])
        allow(validator).to receive(:other_group_check).with(record).and_return(false)
      end

      it 'returns true' do
        expect(validator.send(:has_other_skip_exemptions?, record)).to be true
      end
    end
  end

  describe '#other_group_check' do
    let(:miam_exemption) { double('miam_exemption') }
    let(:miam_exemption_claim) { 'yes' }

    before do
      allow(record).to receive(:miam_exemption).and_return(miam_exemption)
    end

    context 'when all groups include misc_<group>_none' do
      before do
        allow(miam_exemption).to receive(:protection).and_return(['misc_protection_none'])
        allow(miam_exemption).to receive(:urgency).and_return(['misc_urgency_none'])
        allow(miam_exemption).to receive(:adr).and_return(['misc_adr_none'])
      end

      it 'returns true' do
        expect(validator.send(:other_group_check, record)).to be true
      end
    end

    context 'when one group does not include "misc_<group>_none"' do
      before do
        allow(miam_exemption).to receive(:protection).and_return(['misc_protection_none'])
        allow(miam_exemption).to receive(:urgency).and_return(['misc_urgency_present'])
        allow(miam_exemption).to receive(:adr).and_return(['misc_adr_none'])
      end

      it 'returns false' do
        expect(validator.send(:other_group_check, record)).to be false
      end
    end

    context 'when all groups are empty' do
      before do
        allow(miam_exemption).to receive(:protection).and_return([])
        allow(miam_exemption).to receive(:urgency).and_return([])
        allow(miam_exemption).to receive(:adr).and_return([])
      end

      it 'returns false' do
        expect(validator.send(:other_group_check, record)).to be false
      end
    end
  end

  context 'generate_document_validation' do
    subject{ ApplicationFulfilmentValidator.new }
    let(:document_type) { :miam_certificate }
    let(:path) { '/upload/path' }
    let(:checks) { [:miam_exemption_claim?,:child_protection_cases?, :consent_order?] }
    let(:invert) { false }

    before do
      allow(record).to receive(:document).and_return(nil)
    end

    context 'for miam' do

      before do
        allow(record).to receive(:consent_order?).and_return(false)
        allow(record).to receive(:child_protection_cases?).and_return(false)
        allow(record).to receive(:miam_exemption_claim?).and_return(false)
      end

      it 'returns nil when document is present' do
        allow(record).to receive(:document).with(document_type).and_return(true)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to be_nil
      end

      it 'returns nil when the application is a consent order' do
        allow(record).to receive(:consent_order?).and_return(true)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to be_nil
      end

      it 'returns nil when the application is a child_protection_cases' do
        allow(record).to receive(:child_protection_cases?).and_return(true)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to be_nil
      end

      it 'returns nil when the application is a miam_exemption_claim' do
        allow(record).to receive(:miam_exemption_claim?).and_return(true)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to be_nil
      end

      it 'returns error variables when the document is missing and no checks fail' do
        allow(record).to receive(:document).with(document_type).and_return(false)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to eq([:files_collection_ref, :blank, path])
      end
    end

    context 'for consent_order' do
      let(:document_type) { :draft_consent_order }
      let(:checks) { [:consent_order?] }
      let(:invert) { true }

      before do
        allow(record).to receive(:consent_order?).and_return(false)
      end

      it 'returns nil when document is present' do
        allow(record).to receive(:document).with(document_type).and_return(true)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to be_nil
      end

      it 'returns error variables when the document is missing and consent_order? is true' do
        allow(record).to receive(:consent_order?).and_return(true)
        allow(record).to receive(:document).with(document_type).and_return(false)

        validation_send = subject.send(:generate_document_validation, document_type, path, checks, invert: invert)

        expect(validation_send.call(record)).to eq([:files_collection_ref, :blank, path])
      end
    end
  end
end
