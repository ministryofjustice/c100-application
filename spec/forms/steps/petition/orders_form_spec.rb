require 'spec_helper'

RSpec.describe Steps::Petition::OrdersForm do
  let(:arguments) { {
    c100_application: c100_application,
    orders: orders,
    orders_collection: orders_collection
  } }

  let(:c100_application) {
    instance_double(C100Application, orders: orders)
  }

  let(:orders) { %w(child_arrangements_home group_prohibited_steps group_specific_issues) }
  let(:orders_collection) { %w(prohibited_steps_holiday specific_issues_medical) }

  subject { described_class.new(arguments) }

  describe 'custom getter override' do
    it 'returns all the orders in all attributes' do
      expect(
        subject.orders_collection
      ).to eq(orders_collection + orders)
    end

    # mutant kill
    context 'when `orders_collection` is nil' do
      let(:orders_collection) { nil }

      it 'returns all the orders in all attributes' do
        expect(
          subject.orders_collection
        ).to eq(orders)
      end
    end

    # mutant kill
    context 'when `orders` is nil' do
      let(:orders) { nil }

      it 'returns all the orders in all attributes' do
        expect(
          subject.orders_collection
        ).to eq(orders_collection)
      end
    end
  end

  describe 'clean options' do
    # Remove the group selections
    let(:orders) { %w(child_arrangements_home) }

    it 'removes options that are no longer visible' do
      expect(
        subject.send(:clean_options)
      ).to eq(orders)
    end
  end

  describe 'validations' do
    # mutant kill
    context 'when `orders` attribute is not submitted' do
      let(:arguments) { {
        c100_application: c100_application,
        orders_collection: [],
      } }

      it 'has a validation error' do
        expect(subject).to_not be_valid
        expect(subject.errors.added?(:orders, :blank)).to eq(true)
      end
    end

    context 'when no checkboxes are selected' do
      let(:orders) { nil }
      let(:orders_collection) { nil }

      it 'has a validation error' do
        expect(subject).to_not be_valid
        expect(subject.errors.added?(:orders, :blank)).to eq(true)
      end
    end

    context 'when only group checkboxes are selected' do
      let(:orders) { ['group_prohibited_steps'] }
      let(:orders_collection) { nil }

      it 'has a validation error' do
        expect(subject).to_not be_valid
        expect(subject.errors.added?(:orders, :blank)).to eq(true)
      end
    end

    context 'when prohibited steps is ticked but lacks an item' do
      let(:orders) { ['child_arrangements_home', 'group_prohibited_steps'] }
      let(:orders_collection) { nil }

      it 'has a validation error' do
        expect(subject).to_not be_valid
        expect(subject.errors.added?(:orders, :missing_prohibited_step)).to eq(true)
      end      
    end

    context 'when specific issue is ticked but lacks an item' do
      let(:orders) { ['child_arrangements_home', 'group_specific_issues'] }
      let(:orders_collection) { nil }

      it 'has a validation error' do
        expect(subject).to_not be_valid
        expect(subject.errors.added?(:orders, :missing_specific_issue)).to eq(true)
      end      
    end

    context 'when invalid checkbox values are submitted' do
      context 'in `orders` attribute' do
        let(:orders) { ['foobar'] }
        let(:orders_collection) { nil }

        it 'has a validation error' do
          expect(subject).to_not be_valid
          expect(subject.errors.added?(:orders, :blank)).to eq(true)
        end
      end

      context 'in `orders_collection` attribute' do
        let(:orders) { nil }
        let(:orders_collection) { ['foobar'] }

        it 'has a validation error' do
          expect(subject).to_not be_valid
          expect(subject.errors.added?(:orders, :blank)).to eq(true)
        end
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

    context 'when form is valid' do
      it 'saves the record' do
        expect(c100_application).to receive(:update).with(
          orders: %w(prohibited_steps_holiday specific_issues_medical child_arrangements_home group_prohibited_steps group_specific_issues)
        ).and_return(true)

        expect(subject.save).to be(true)
      end

      context 'when `another issue` checkbox is selected' do
        let(:orders) { %w(other_issue) }
        let(:orders_collection) { nil }

        it 'saves the record' do
          expect(c100_application).to receive(:update).with(
            orders: %w(other_issue)
          ).and_return(true)

          expect(subject.save).to be(true)
        end
      end

      context 'for a consent order' do
        let(:arguments) { {
          c100_application: c100_application,
          orders: %w(consent_order)
        } }

        it 'saves the record' do
          expect(c100_application).to receive(:update).with(
            orders: %w(consent_order)
          ).and_return(true)

          expect(subject.save).to be(true)
        end
      end
    end
  end
end
