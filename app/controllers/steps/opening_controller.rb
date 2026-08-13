module Steps
  class OpeningController < ApplicationController
    def root
      redirect_to steps_opening_start_or_continue_path(new: params[:new], change: params[:change]), allow_other_host: true
    end
  end
end
