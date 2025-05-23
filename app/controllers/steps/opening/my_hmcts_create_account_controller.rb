module Steps
  module Opening
    class MyHmctsCreateAccountController < Steps::OpeningStepController
      skip_before_action :check_c100_application_presence, :update_navigation_stack, if: -> { PrlChange.changes_apply? }

      def show
        redirect_to 'https://www.gov.uk/guidance/myhmcts-online-case-management-for-legal-professionals#create-a-myhmcts-account-for-your-organisation',
                    status: 301, allow_other_host: true
      end
    end
  end
end
