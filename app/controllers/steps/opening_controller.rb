module Steps
  class OpeningController < ApplicationController
    def root
      if PrlChange.changes_apply?
        redirect_to steps_opening_start_or_continue_path(new: params[:new], change: params[:change])
      else
        redirect_to steps_opening_start_path(new: params[:new])
      end
    end
  end
end
