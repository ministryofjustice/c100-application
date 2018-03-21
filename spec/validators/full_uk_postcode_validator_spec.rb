require 'rails_helper'

describe FullUkPostcodeValidator do
  subject { described_class.new({attributes: {foo: 'bar'}}) }

  let(:postcode){ 'yo16 5RB' }

  describe '#parsed_postcode' do
    it 'parses the given postcode with UKPostcode' do
      expect(UKPostcode).to receive(:parse).with(postcode).and_return('foo')
      subject.parsed_postcode(postcode)
    end
    it 'returns the parsed postcode' do
      allow(UKPostcode).to receive(:parse).with(postcode).and_return('foo')
      expect(subject.parsed_postcode(postcode)).to eq('foo')
    end
  end

  describe '#validate_each' do
    let(:exists){ true }
    let(:well_formed){ true }
    let(:errors){ { attribute => [] } }
    let(:record){ double('record', errors: errors) }
    let(:attribute){ :foo }

    before do
      allow(subject).to receive(:exists?).and_return(exists)
      allow(subject).to receive(:well_formed?).and_return(well_formed)
    end

    context 'given a nil value' do
      it 'does not raise an error' do
        expect{ subject.validate_each(record, attribute, nil) }.to_not raise_error
      end
    end

    context 'given a multi-line value' do
      let(:value){ 'postcode1\npostcode2' }

      it 'calls well_formed? with each entry' do
        expect(subject).to receive(:well_formed?).with('postcode1').and_return(true)
        expect(subject).to receive(:well_formed?).with('postcode2').and_return(true)
        subject.validate_each(record, attribute, value)
      end

      context 'when the postcodes are well_formed?' do
        before do
          allow(subject).to receive(:well_formed?).and_return(true)
        end
        it 'calls exists? with each entry' do
          expect(subject).to receive(:exists?).with('postcode1').and_return(true)
          expect(subject).to receive(:exists?).with('postcode2').and_return(true)
          subject.validate_each(record, attribute, value)
        end

        context 'but do not exist' do
          let(:exists){ false }

          it 'adds an error to the attribute' do
            subject.validate_each(record, attribute, value)
            expect(record.errors[attribute]).to_not be_empty
          end

          describe 'the error' do
            let(:error){ errors[attribute].last }

            it 'is the error_message' do
              subject.validate_each(record, attribute, value)
              expect(error).to eq(subject.error_message)
            end

          end

          context 'given an attribute that does not exist' do
            it 'does not raise an error' do
              expect{ subject.validate_each(record, :non_existent_attribute, value) }.to_not raise_error
            end
          end
        end

        context 'and exist' do
          let(:exists){ true }

          it 'does not add an error to the attribute' do
            expect(errors[attribute]).to be_empty
            subject.validate_each(record, attribute, value)
          end
        end
      end

      context 'when the postcodes are not well_formed?' do
        before do
          allow(subject).to receive(:well_formed?).and_return(false)
        end
        it 'does not calls exists?' do
          expect(subject).to_not receive(:exists?)
          subject.validate_each(record, attribute, value)
        end
      end

      context 'with an empty line' do
        let(:value){ 'postcode1\n  \npostcode2' }

        it 'does not call well_formed? with the empty value' do
          expect(subject).to_not receive(:well_formed?).with('  ')
          subject.validate_each(record, attribute, value)
        end
      end
    end
  end

  describe '#error_message' do
    it 'translates the correct error string' do
      expect(I18n).to receive(:t).with(:invalid, scope: [:errors, :attributes, :children_postcodes]).and_return 'foo'
      subject.error_message
    end

    it 'returns the translated string' do
      expect(subject.error_message).to eq(I18n.t(:invalid, scope: [:errors, :attributes, :children_postcodes]))
    end
  end

  describe '#well_formed?' do
    let(:valid){ 'oh yes' }
    let(:parsed_postcode){ instance_double(UKPostcode::GeographicPostcode, full_valid?: valid) }

    it 'parses the given postcode' do
      expect(subject).to receive(:parsed_postcode).with(postcode).and_return(parsed_postcode)
      subject.well_formed?(postcode)
    end

    it 'returns the value of full_valid? on the parsed postcode' do
      allow(subject).to receive(:parsed_postcode).and_return(parsed_postcode)
      expect(subject.well_formed?(postcode)).to eq(valid)
    end
  end

  describe '#exists?' do
    let(:code){ '200' }
    let(:response){ double('response', code: code) }
    let(:mapit_uri){ instance_double(URI) }
    before do
      allow(subject).to receive(:mapit_uri).with(postcode).and_return(mapit_uri)
      allow(Net::HTTP).to receive(:get_response).and_return(response)
    end
    it 'gets the mapit_uri for the given postcode' do
      expect(subject).to receive(:mapit_uri).with(postcode).and_return(mapit_uri)
      subject.exists?(postcode)
    end

    it 'gets the response of a HTTP request to the mapit_uri' do
      expect(Net::HTTP).to receive(:get_response).with(mapit_uri).and_return(response)
      subject.exists?(postcode)
    end

    context 'when the response code is "200"' do
      it 'returns true' do
        expect(subject.exists?(postcode)).to eq(true)
      end
    end
    context 'when the response code is not "200"' do
      let(:code){ '404' }
      it 'returns false' do
        expect(subject.exists?(postcode)).to eq(false)
      end
    end
  end

  describe '#mapit_uri' do
    let(:uri){ instance_double(URI) }
    let(:escaped_postcode){ 'AA1%202BB' }
    let(:mapit_uri_root){ 'https://example.com/' }
    before do
      allow(CGI).to receive(:escape).with(postcode).and_return(escaped_postcode)
      allow(subject).to receive(:mapit_uri_root).and_return(mapit_uri_root)
    end

    it 'joins the mapit_uri_root with the escaped postcode' do
      expect(URI).to receive(:join).with(mapit_uri_root, escaped_postcode).and_return(uri)
      subject.mapit_uri(postcode)
    end
    it 'returns a URI' do
      expect(subject.mapit_uri(postcode)).to be_a(URI)
    end
  end

  describe '#mapit_uri_root' do
    it 'is MAPIT_URI_ROOT' do
      expect(subject.mapit_uri_root).to eq(described_class::MAPIT_URI_ROOT)
    end
  end
end
