require 'rails_helper'

RSpec.describe RemoveExistingCourtOrderHelper, type: :helper do
  let(:c100_application) { instance_double( C100Application, files_collection_ref: files_collection_ref,
                                            existing_court_order_uploadable: existing_court_order_uploadable) }
  let(:document) { double("Document") }
  let(:files_collection_ref) { '123' }
  let(:existing_court_order_uploadable) { 'no' }

  describe "#remove_file_if_no_uploadable" do
    context "when existing_court_order_uploadable is 'no' and existing_court_order document exists" do
      before do
        allow(c100_application).to receive(:document).with(:existing_court_order).and_return(document)
        allow(document).to receive(:name).and_return("file_name.pdf")
        allow(Uploader).to receive(:delete_file)
      end

      it "deletes the existing_court_order document" do
        expect(Uploader).to receive(:delete_file).with(
          collection_ref: "123",
          document_key: :existing_court_order,
          filename: "file_name.pdf"
        )
        helper.remove_file_if_no_uploadable(c100_application)
      end
    end

    context "when existing_court_order_uploadable is not no" do
      before do
        allow(c100_application).to receive(:document).with(:existing_court_order).and_return(document)
      end

      let(:existing_court_order_uploadable) { 'yes' }

      it "does not delete any file" do
        expect(Uploader).not_to receive(:delete_file)
        helper.remove_file_if_no_uploadable(c100_application)
      end
    end

    context "when existing_court_order document does not exist" do
      before do
        allow(c100_application).to receive(:document).with(:existing_court_order).and_return(nil)
      end

      it "does not delete any file" do
        expect(Uploader).not_to receive(:delete_file)
        helper.remove_file_if_no_uploadable(c100_application)
      end
    end
  end
end
