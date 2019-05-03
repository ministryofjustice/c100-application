RSpec.shared_examples 'a address CRUD form' do |form_class, |
  let(:collection_name) { ActiveModel::Name.new(form_class).collection }

  let(:arguments) do
    {
      c100_application: c100_application,
      record: record,
      address: address,
      address_line_1: address_line_1,
      address_line_2: address_line_2,
      town: town,
      country: country,
      postcode: postcode,
      address: address,
      address_unknown: address_unknown,
      residence_requirement_met: residence_requirement_met,
      residence_history: residence_history
    }
  end

  let(:c100_application) { instance_double(C100Application, collection_name => record_collection) }
  let(:record_collection) { double('record_collection') }
  let(:model) { double(form_class.name, id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe9') }

  let(:record) { nil }
  let(:address) { 'address' }
  let(:address_unknown) { false }
  let(:residence_requirement_met) { 'no' }
  let(:residence_history) { 'history' }

  let(:address_line_1) { nil }
  let(:address_line_2) { nil }
  let(:town) { nil }
  let(:country) { nil }
  let(:postcode) { nil }
  let(:split_address_result) { false }

  before do
    allow(subject).to receive(:split_address?).and_return(split_address_result)
  end

  subject { described_class.new(arguments) }

  describe '#validate_address?' do
    context 'returns true' do
      context 'when address_unknown is true and split_address is false' do
        let(:address_unknown) { true }
        it { expect(subject.validate_address?).to eq(true) }
      end

      context 'when address_unknown is false and split_address is true' do
        let(:split_address_result) { true }
        it { expect(subject.validate_address?).to eq(true) }
      end

      context 'when address_unknown is true and split_address is true' do
        let(:split_address_result) { true }
        let(:address_unknown) { true }
        it { expect(subject.validate_address?).to eq(true) }
      end
    end

    context 'returns false' do
      context 'when address_unknown is false and split_address is false' do
        let(:split_address_result) { false }
        let(:address_unknown) { false }
        it { expect(subject.validate_address?).to eq(false) }
      end

      context 'when address_unknown is nil? and split_address is false' do
        let(:address_unknown) { nil }
        it { expect(subject.validate_address?).to eq(false) }
      end
    end
  end

  describe '#validate_split_address?' do
    context 'returns true' do
      context 'when address_unknown is false and split_address is true' do
        let(:address_unknown) { false }
        let(:split_address_result) { true }
        it { expect(subject.validate_split_address?).to eq(true) }
      end
    end

    context 'returns false' do
      context 'when address_unknown is true and split_address is true' do
        let(:split_address_result) { true }
        let(:address_unknown) { true }
        it { expect(subject.validate_split_address?).to eq(false) }
      end

      context 'when address_unknown is false and split_address is false' do
        let(:split_address_result) { false }
        let(:address_unknown) { false }
        it { expect(subject.validate_split_address?).to eq(false) }
      end

      context 'when address_unknown is nil? and split_address is false' do
        let(:address_unknown) { nil }
        it { expect(subject.validate_split_address?).to eq(false) }
      end
    end
  end



  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'residence_requirement_met' do
      context 'when attribute is not given' do
        let(:residence_requirement_met) { nil }

        it 'returns false' do
          expect(subject.save).to be(false)
        end

        it 'has a validation error on the field' do
          expect(subject).to_not be_valid
          expect(subject.errors[:residence_requirement_met]).to_not be_empty
        end
      end

      context 'when attribute is given and requires residency history' do
        let(:residence_requirement_met) { 'no' }
        let(:residence_history) { nil }

        it 'has a validation error on the `residence_history` field' do
          expect(subject).to_not be_valid
          expect(subject.errors[:residence_history]).to_not be_empty
        end
      end

      context 'when attribute is given and does not requires residency history' do
        let(:residence_requirement_met) { 'yes' }
        let(:residence_history) { nil }

        it 'has no validation errors' do
          expect(subject).to be_valid
        end
      end
    end

    context 'validations on field presence unless `unknown`' do
      before { allow(subject).to receive(:validate_address?).and_return(true) }
      it { should validate_presence_unless_unknown_of(:address) }
    end
  end
end
