require 'rails_helper'

describe Court do
  subject { described_class.build(data) }

  let(:data) {
    {
      "name" => 'Court name',
      "slug" => 'court-slug',
      "email" => 'family@court',
      "address" => address,
      "gbs" => 'X123',
    }
  }

  let(:address) {
    {
      "address_lines" => ["351 Silbury Boulevard", "Witan Gate East"],
      "town" => "Central Milton Keynes",
      "postcode" => "MK9 2DT",
    }
  }

  describe '.build' do
    it 'sets the name' do
      expect(subject.name).to eq('Court name')
    end

    it 'sets the slug' do
      expect(subject.slug).to eq('court-slug')
    end

    it 'sets the address' do
      expect(subject.address).to eq(address)
    end

    it 'sets the gbs code' do
      expect(subject.gbs).to eq('X123')
    end

    context 'log and raise exception when attributes not found' do
      context 'name' do
        let(:data) { super().except('name') }

        it 'sends the exception to Sentry with extra context' do
          expect(Raven).to receive(:extra_context).with(data: data)
          expect(Raven).to receive(:capture_exception).with(an_instance_of(KeyError))
          expect { subject.name }.to raise_error(KeyError, 'key not found: "name"')
        end
      end

      context 'slug' do
        let(:data) { super().except('slug') }

        it 'sends the exception to Sentry with extra context' do
          expect(Raven).to receive(:extra_context).with(data: data)
          expect(Raven).to receive(:capture_exception).with(an_instance_of(KeyError))
          expect { subject.name }.to raise_error(KeyError, 'key not found: "slug"')
        end
      end

      context 'address' do
        let(:data) { super().except('address') }

        it 'sends the exception to Sentry with extra context' do
          expect(Raven).to receive(:extra_context).with(data: data)
          expect(Raven).to receive(:capture_exception).with(an_instance_of(KeyError))
          expect { subject.name }.to raise_error(KeyError, 'key not found: "address"')
        end
      end
    end

    context 'gbs' do
      context 'there is a gbs code in the data provided' do
        it 'sets the gbs' do
          expect(subject.gbs).to eq('X123')
        end

        it 'does not request the gbs from the API' do
          expect(subject).not_to receive(:retrieve_gbs_from_api)
          subject.gbs
        end
      end

      context 'there is no gbs code in the data provided' do
        let(:data) { super().except('gbs') }

        before do
          allow_any_instance_of(
            C100App::CourtfinderAPI
          ).to receive(:court_lookup).with('court-slug').and_return(api_response)
        end

        context 'the API returned gbs' do
          let(:api_response) do
            { 'gbs' => 'A123' }
          end

          it 'sets the gbs code' do
            expect(subject.gbs).to eq('A123')
          end
        end

        context 'the API returned a `nil` gbs' do
          let(:api_response) do
            { 'gbs' => nil }
          end

          it 'sets the gbs fallback code' do
            expect(subject.gbs).to eq('unknown')
          end
        end

        context 'the API returned a blank gbs' do
          let(:api_response) do
            { 'gbs' => '' }
          end

          it 'sets the gbs fallback code' do
            expect(subject.gbs).to eq('unknown')
          end
        end

        context 'the API failed to return gbs' do
          let(:api_response) { {} }
          it { expect { subject.gbs }.to raise_error(KeyError, 'key not found: "gbs"') }
        end
      end
    end

    context 'email' do
      context 'there is an email in the data provided' do
        it 'sets the email' do
          expect(subject.email).to eq('family@court')
        end

        it 'does not request the list of emails from the API' do
          expect(subject).not_to receive(:retrieve_emails_from_api)
          subject.email
        end
      end

      context 'there is no email in the data provided' do
        let(:data) { super().except('email') }

        before do
          allow_any_instance_of(
            C100App::CourtfinderAPI
          ).to receive(:court_lookup).with('court-slug').and_return(api_response)
        end

        context 'the API returned emails' do
          let(:api_response) do
            { 'emails' => [{"description" => "applications", "address" => "applications@email"}] }
          end

          it 'sets the email' do
            expect(subject.email).to eq('applications@email')
          end
        end

        context 'the API failed to return emails' do
          let(:api_response) { {} }
          it { expect { subject.email }.to raise_error(KeyError, 'key not found: "emails"') }
        end
      end
    end
  end

  describe '#full_address' do
    let(:address) { { 'address_lines' => address_lines, 'town' => 'town', 'postcode' => 'postcode' } }
    let(:address_lines){ ['line 1', 'line 2'] }

    it 'returns a flattened array of name, address_lines, town and postcode' do
      expect(subject.full_address).to eq(['Court name', 'line 1', 'line 2', 'town', 'postcode'])
    end

    context 'when any lines are duplicated' do
      let(:address_lines){ ['Court name', 'postcode'] }

      it 'removes the duplicates' do
        expect(subject.full_address).to eq(['Court name', 'postcode', 'town'])
      end
    end

    context 'when any lines are blank' do
      let(:address_lines){ ['line 1', ''] }

      it 'removes the blank lines' do
        expect(subject.full_address).to eq(['Court name', 'line 1', 'town', 'postcode'])
      end
    end
  end

  describe '#best_enquiries_email' do
    before do
      allow(subject).to receive(:retrieve_emails_from_api).and_return(emails)
    end

    context 'email list is empty' do
      let(:emails){ [] }
      it { expect { subject.best_enquiries_email }.to raise_error(KeyError, 'key not found: "address"') }
    end

    context 'email list is not empty but wrong format' do
      let(:emails){ [{"key" => "value"}] }
      it { expect { subject.best_enquiries_email }.to raise_error(KeyError, 'key not found: "address"') }
    end

    context 'given an array of email hashes' do
      context 'containing an email with description matching "children"' do
        let(:emails){
          [
            {
              'description' => 'Enquiries',
              'address' => 'enquiries@email',
            },
            {
              'description' => 'All Children Enquiries',
              'address' => 'children@email'
            }
          ]
        }

        it 'returns the email address of the matching description' do
          expect(subject.best_enquiries_email).to eq('children@email')
        end

        context 'and containing an email with description matching "family"' do
          let(:emails){
            [
              {
                'description' => 'All children enquiries',
                'address' => 'children@email'
              },
              {
                'description' => 'All Family Enquiries',
                'address' => 'family@email'
              }
            ]
          }
          it 'returns the email address of the description matching children' do
            expect(subject.best_enquiries_email).to eq('children@email')
          end

          context 'and containing an email with description equal to "applications"' do
            let(:emails){
              [
                {
                  'description' => 'Applications',
                  'address' => 'applications@email'
                },
                {
                  'description' => 'All Family Enquiries',
                  'address' => 'family@email'
                }
              ]
            }
            it 'returns the email address of the description equal to "Applications"' do
              expect(subject.best_enquiries_email).to eq('applications@email')
            end
          end
        end

        context 'and containing an email matching "enquiries"' do
          let(:emails){
            [
              {
                'description' => 'Enquiries',
                'address' => 'enquiries@email',
              },
              {
                'description' => 'All children things',
                'address' => 'children@email'
              },
            ]
          }

          it 'returns the email address matching children' do
            expect(subject.best_enquiries_email).to eq('children@email')
          end
        end
      end

      context 'containing an email with description matching "family"' do
        let(:emails){
          [
            {
              'description' => 'Enquiries',
              'address' => 'enquiries@email',
            },
            {
              'description' => 'All Family Enquiries',
              'address' => 'family@email'
            }
          ]
        }

        it 'returns the email address of the matching description' do
          expect(subject.best_enquiries_email).to eq('family@email')
        end

        context 'and containing an email with description matching "enquiries"' do
          let(:emails){
            [
              {
                'description' => 'Enquiries',
                'address' => 'enquiries@email',
              },
              {
                'description' => 'All family things',
                'address' => 'family@email'
              }
            ]
          }

          it 'returns the email address of the description matching family' do
            expect(subject.best_enquiries_email).to eq('family@email')
          end
        end
      end

      context 'containing an email with description matching "applications" and another with explanation matching "family"' do
        let(:emails) {
          [
            {
              'description' => 'Applications',
              'address' => 'applications@email'
            },
            {
              'description' => 'Anything',
              'explanation' => 'Family',
              'address' => 'email@example',
            },
          ]
        }

        it 'returns the email address of the matching explanation' do
          expect(subject.best_enquiries_email).to eq('email@example')
        end
      end

      context 'containing an email with description matching "applications"' do
        let(:emails) {
          [
            {
              'description' => 'Anything',
              'explanation' => 'other queries',
              'address' => 'email@example',
            },
            {
              'description' => 'C100 applications',
              'address' => 'c100@email'
            }
          ]
        }

        it 'returns the email address of the matching explanation' do
          expect(subject.best_enquiries_email).to eq('c100@email')
        end
      end

      context 'containing an email with explanation matching "family" but also enquiries' do
        let(:emails){
          [
            {
              'description' => 'Other enquiries',
              'address' => 'other.enquiries@email'
            },
            {
              'description' => '',
              'explanation' => 'Family enquiries',
              'address' => 'enquiries@email',
            },
          ]
        }

        it 'returns the email address of the matching explanation' do
          expect(subject.best_enquiries_email).to eq('enquiries@email')
        end
      end

      context 'containing email addresses matching "children" or "family"' do
        let(:emails){
          [
            {
              'description' => 'Anything',
              'address' => 'Family@email'
            },
            {
              'description' => '',
              'explanation' => 'Explanation',
              'address' => 'Children@email',
            },
          ]
        }

        it 'returns the matching email address based on priority' do
          expect(subject.best_enquiries_email).to eq('Children@email')
        end
      end

      context 'nothing matches except the enquiries email address' do
        let(:emails){
          [
            {
              'description' => 'Should not match anything',
              'address' => 'my@email',
            },
            {
              'description' => 'No address',
            },
            {
              'description' => 'Any description',
              'address' => 'Enquiries@email',
            },
          ]
        }
        it 'returns the `enquiries` email' do
          expect(subject.best_enquiries_email).to eq('Enquiries@email')
        end
      end

      context 'that is not empty but matches no other criterion' do
        let(:emails){
          [
            {
              'description' => 'Should not match anything',
              'address' => 'my@email',
            },
            {
              'description' => 'Another non-matching email',
              'address' => 'not@this.one'
            }
          ]
        }
        it 'returns the first email' do
          expect(subject.best_enquiries_email).to eq('my@email')
        end
      end
    end
  end

  describe '#gbs_known?' do
    context 'for a valid GBS code' do
      it 'returns true' do
        expect(subject.gbs_known?).to eq(true)
      end
    end

    context 'for an unknown GBS code' do
      it 'returns false' do
        expect(subject).to receive(:gbs).and_return('unknown')
        expect(subject.gbs_known?).to eq(false)
      end
    end
  end

  # TODO: preparation for future screener removal
  describe '#as_json' do
    it 'excludes some attributes' do
      expect(subject.as_json).not_to include('created_at', 'updated_at', 'id')
    end

    it 'includes the attributes we need' do
      expect(subject.as_json).to include('name', 'address', 'email', 'gbs', 'slug')
    end

    # Mutant killer for arguments
    it 'can be called with arguments, but we do not use them' do
      expect(subject.as_json({})).to be_kind_of(Hash)
    end
  end
end
