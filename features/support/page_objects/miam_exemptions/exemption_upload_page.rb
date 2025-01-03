class ExemptionUploadPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/exemption_upload'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Upload your evidence for a MIAM exemption'
    element :p_1, 'p', text: 'If you are uploading documents from a computer, name the files clearly. For example, miam-exemption.pdf'
    element :p_2, 'p', text: 'Files must end with JPG, BMP, PNG, TIF, PDF, DOC or DOCX'
    element :span_1, 'span', text: 'How to take a picture of a document on your phone and upload it'
    element :li_1, 'li', text: 'Place your document on a flat service in a well-lit room. Use a flash if you need to.'
    element :li_2, 'li', text: 'Take a picture of the whole document. You should be able to see its edges.'
    element :li_3, 'li', text: 'Check you can read all the writing, including the handwriting.'
    element :li_4, 'li', text: 'Email or send the photo or scan to the device you are using now.'
    element :li_5, 'li', text: 'Upload it here.'
    element :p_3, 'p', text: 'Select document to upload'
    element :p_4, 'p', text: 'Your document will upload when you click \'Continue\'.'
    element :label, 'p', text: 'Select file'
    element :span_2, 'span', text: 'File upload requirements'
    element :li_6, 'li', text: 'File formats: MS Word, MS Excel, PDF, JPG, GIF, PNG, TXT, RTF'
    element :li_7, 'li', text: 'File size per document: up to 20 megabytes (MB)'
    element :li_8, 'li', text: 'Files cannot be password protected'
    element :li_9, 'li', text: 'Do not use the following (reserved) characters in the filename - #, $, +, %, &, {}, [], <>,*, =, and ? as these may result in a problem uploading the file or retrieving the file once uploaded'
    element :li_10, 'li', text: 'Do not use spaces and full stops (\'.\') at the start or end of the filename as this may result in a problem uploading the file or retrieving the file once uploaded'
    element :li_11, 'li', text: 'If invalid characters are left within the filename, the system will attempt to remove these, resulting in the uploaded filename being different to the filename at the point of upload. A problem may also be encountered when retrieving the file once uploaded'
    element :inset_text, 'p', text: 'You can’t upload executable (.exe), zip or other archive files due to virus risks.'

    element :continue_button, 'button', text: 'Continue'
  end
end
