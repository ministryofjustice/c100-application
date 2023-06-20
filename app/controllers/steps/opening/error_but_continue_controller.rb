module Steps
  module Opening
    class ErrorButContinueController < Steps::OpeningStepController
      def show
        @courtfinder_output = params[:courtfinder_output]
        @courtfinder_ok = C100App::CourtfinderAPI.new.is_ok?
      end
    end
  end
end
