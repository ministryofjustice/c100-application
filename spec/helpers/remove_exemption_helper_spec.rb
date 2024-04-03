require 'rails_helper'

RSpec.describe RemoveExemptionHelper, type: :helper do
  let(:c100_application) { instance_double( C100Application, files_collection_ref: files_collection_ref,
                                            attach_evidence: attach_evidence) }
  let(:document) { double("Document") }
  let(:files_collection_ref) { '123' }
  let(:attach_evidence) { 'no' }

  describe "#remove_file_if_no_evidence" do
    context "when attach_evidence is 'no' and exemption document exists" do
      before do
        allow(c100_application).to receive(:document).with(:exemption).and_return(document)
        allow(document).to receive(:name).and_return("file_name.pdf")
        allow(Uploader).to receive(:delete_file)
      end

      it "deletes the exemption document" do
        expect(Uploader).to receive(:delete_file).with(
          collection_ref: "123",
          document_key: :exemption,
          filename: "file_name.pdf"
        )
        helper.remove_file_if_no_evidence(c100_application)
      end
    end

    context "when attach_evidence is not no" do
      before do
        allow(c100_application).to receive(:document).with(:exemption).and_return(document)
      end

      let(:attach_evidence) { 'yes' }

      it "does not delete any file" do
        expect(Uploader).not_to receive(:delete_file)
        helper.remove_file_if_no_evidence(c100_application)
      end
    end

    context "when exemption document does not exist" do
      before do
        allow(c100_application).to receive(:document).with(:exemption).and_return(nil)
      end

      it "does not delete any file" do
        expect(Uploader).not_to receive(:delete_file)
        helper.remove_file_if_no_evidence(c100_application)
      end
    end
  end
end
