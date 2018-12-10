require 'rails_helper'

RSpec.describe ApplicantDeliveryJob, type: :job do
  let(:c100_application) { instance_double(C100Application) }
  let(:queue) { double.as_null_object }

  describe '#perform' do
    it 'calls the `OnlineSubmission` service to process the application' do
      expect(C100App::OnlineSubmission).to receive(:new).with(
        c100_application, recipient: :applicant
      ).and_return(queue)

      expect(queue).to receive(:process)

      ApplicantDeliveryJob.perform_now(c100_application)
    end
  end
end
