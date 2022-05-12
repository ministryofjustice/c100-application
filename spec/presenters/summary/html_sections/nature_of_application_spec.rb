require 'spec_helper'

module Summary
  describe HtmlSections::NatureOfApplication do
    let(:c100_application) {
      instance_double(C100Application,
        orders: orders,
        protection_orders: 'yes',
        protection_orders_details: 'protection orders details',
      )
    }

    subject { described_class.new(c100_application) }

    let(:orders){
      [
        "child_arrangements_home",
        "child_arrangements_time",
        "group_prohibited_steps",
        "prohibited_steps_medical",
        "prohibited_steps_holiday",
        "prohibited_steps_moving",
        "group_specific_issues",
        "specific_issues_school",
        "specific_issues_religion",
        "specific_issues_names",
        "other_issue"
      ]
    }
    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:nature_of_application) }
    end

    describe '#answers' do
      it 'has the correct rows' do
        expect(answers.count).to eq(4)

        expect(answers[0]).to be_an_instance_of(MultiAnswer)
        expect(answers[0].question).to eq(:child_arrangements_orders)
        expect(answers[0].value).to eq(
          ['child_arrangements_home', 'child_arrangements_time']
        )
        expect(answers[0].change_path).to eq('/steps/petition/orders#steps-petition-orders-form-orders-child-arrangements-home-field')

        expect(answers[1]).to be_an_instance_of(MultiAnswer)
        expect(answers[1].question).to eq(:prohibited_steps_orders)
        expect(answers[1].value).to eq(
          [
            'prohibited_steps_medical',
            'prohibited_steps_holiday',
            'prohibited_steps_moving'
          ]
        )
        expect(answers[1].change_path).to eq('/steps/petition/orders#steps-petition-orders-form-orders-group-prohibited-steps-field')

        expect(answers[2]).to be_an_instance_of(MultiAnswer)
        expect(answers[2].question).to eq(:specific_issues_orders)
        expect(answers[2].value).to eq([
          'specific_issues_school',
          'specific_issues_religion',
          'specific_issues_names'
        ])
        expect(answers[2].change_path).to eq('/steps/petition/orders#steps-petition-orders-form-orders-group-specific-issues-field')

        expect(answers[3]).to be_an_instance_of(AnswersGroup)
        expect(answers[3].name).to eq(:protection_orders)
        expect(answers[3].change_path).to eq('/steps/petition/protection')
        expect(answers[3].answers.count).to eq(2)

        ## protection_orders group answers ###
        protection = answers[3].answers

        expect(protection[0]).to be_an_instance_of(Answer)
        expect(protection[0].question).to eq(:protection_orders)
        expect(protection[0].value).to eq('yes')

        expect(protection[1]).to be_an_instance_of(FreeTextAnswer)
        expect(protection[1].question).to eq(:protection_orders_details)
        expect(protection[1].value).to eq('protection orders details')
      end

      context 'for a consent order' do
        let(:orders) { ['consent_order'] }

        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(MultiAnswer)
          expect(answers[0].question).to eq(:formalise_arrangements)
          expect(answers[0].value).to eq(['consent_order'])
          expect(answers[0].change_path).to eq('/steps/petition/orders#steps-petition-orders-form-orders-consent-order-field')
        end
      end
    end
  end
end
