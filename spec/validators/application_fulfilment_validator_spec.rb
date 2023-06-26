require 'rails_helper'

module Test
  C100ApplicationValidatable = Struct.new(:children, :applicants, :respondents, :payment_type, :submission_type, keyword_init: true) do
    include ActiveModel::Validations
    validates_with ApplicationFulfilmentValidator
    def document(document_key)
      uploaded_doc = [:miam_certificate, :draft_consent_order]
      uploaded_doc.include?(document_key)
    end

    def generate_document_validation(document_type, path, checks, invert: false)
      lambda do |record|
        unless record.document(document_type) || additional_checks(record, checks, invert)
          [:files_collection_ref, :blank, path]
        end
      end
    end


    def additional_checks(record, checks, invert)
      checks = [checks] unless checks.is_a?(Array)
      checks.map { |check| record.send(check) }.send(invert ? :none? : :any?)
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
    }
  end

  let(:children)    { [Object] }
  let(:applicants)  { [Object] }
  let(:respondents) { [Object] }

  let(:submission_type) { 'submission_type' }
  let(:payment_type)    { 'payment_type' }

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
  end

  context 'generate_document_validation' do
    let(:record) { double('record') }
    let(:validator) { ApplicationFulfilmentValidator.new }

    before do
      allow(subject).to receive(:additional_checks).and_return(true)
    end

    it 'returns the correct error variables when document is missing' do
      allow(record).to receive(:document).with(:miam_certificate).and_return(false)
      allow(subject).to receive(:additional_checks).and_return(false)


      validation_send = subject.send(:generate_document_validation, :miam_certificate, '/upload/path', [])

      expect(validation_send.call(record)).to eq([:files_collection_ref, :blank, '/upload/path'])
    end

    it 'returns nil when document is present' do
      allow(record).to receive(:document).with(:miam_certificate).and_return(true)

      validation_send = subject.send(:generate_document_validation, :miam_certificate, '/upload/path', [])

      expect(validation_send.call(record)).to be_nil
    end

    it 'returns nil when additional checks pass' do
      allow(record).to receive(:document).with(:miam_certificate).and_return(false)

      validation_send = subject.send(:generate_document_validation, :miam_certificate, '/upload/path', [:additional_check])

      expect(validation_send.call(record)).to be_nil
    end
  end
end
