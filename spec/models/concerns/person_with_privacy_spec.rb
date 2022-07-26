require 'rails_helper'

RSpec.describe PersonWithPrivacy do
  let(:test_class) { Applicant }

  subject { test_class.new(
    contact_details_private: contact_details_private
  ) }

  describe '#email_private?' do
    context 'when private' do
      let(:contact_details_private) { ['email'] }
      it 'is private' do
        expect(subject.email_private?).to be_truthy
      end
    end
    context 'when not private' do
      let(:contact_details_private) { [] }
      it 'is not private' do
        expect(subject.email_private?).to be_falsey
      end
    end
  end

  describe '#home_phone_private?' do
    context 'when private' do
      let(:contact_details_private) { ['home_phone'] }
      it 'is private' do
        expect(subject.home_phone_private?).to be_truthy
      end
    end
    context 'when not private' do
      let(:contact_details_private) { [] }
      it 'is not private' do
        expect(subject.home_phone_private?).to be_falsey
      end
    end
  end

  describe '#mobile_private?' do
    context 'when private' do
      let(:contact_details_private) { ['mobile'] }
      it 'is private' do
        expect(subject.mobile_private?).to be_truthy
      end
    end
    context 'when not private' do
      let(:contact_details_private) { [] }
      it 'is not private' do
        expect(subject.mobile_private?).to be_falsey
      end
    end
  end

  describe '#address_private?' do
    context 'when private' do
      let(:contact_details_private) { ['address'] }
      it 'is private' do
        expect(subject.address_private?).to be_truthy
      end
    end
    context 'when not private' do
      let(:contact_details_private) { [] }
      it 'is not private' do
        expect(subject.address_private?).to be_falsey
      end
    end
  end
    
end
