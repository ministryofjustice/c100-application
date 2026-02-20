# require 'rails_helper'

RSpec.describe PaymentsTimeoutJob, type: :job do
  before do
    allow(Rails).to receive(:logger).and_return(logger)

  end



  let(:logger) { instance_double(Logger, info: true) }

  describe '.run' do
    let(:c100_application) { instance_double(C100Application, id: '12345') }

    let(:finder_double) { double.as_null_object }
    let(:time_ago) { 65.minutes.ago }
    let(:start) { 75.minutes.ago }
    let(:ending) { 60.minutes.ago }
    let(:payment_timeout) { double(deliver_later: true) }

    before do
      allow(C100Application).to receive(:joins).with(:payment_intent).and_return(finder_double)
    end

    it 'finds any pending payment intents and sends an email' do
      freeze_time do
        expect(finder_double).to receive(:where).with("(payment_intents.state ->> 'status' = 'submitted') OR
              (payment_intents.state ->> 'status' = 'failed') OR
              (payment_intents.state ->> 'finished' = 'false')").and_return(finder_double)
        expect(finder_double).to receive(:where).
          with("payment_intents.created_at >= :start AND payment_intents.created_at < :ending",
                start: start, ending: ending).and_return(finder_double)

        expect(finder_double).to receive(:each).and_yield(c100_application)
        expect(NotifyMailer).to receive(:payment_timeout).with(c100_application).and_return(payment_timeout)

        described_class.run
      end
    end
  end

end
