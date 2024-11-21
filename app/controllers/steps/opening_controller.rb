module Steps
  class OpeningController < ApplicationController
    def root
      if PrlChange.changes_apply?
        redirect_to steps_opening_start_or_continue_path(new: params[:new], change: params[:change]), allow_other_host: true
      else
        redirect_to steps_opening_start_path(new: params[:new], change: params[:change]), allow_other_host: true
      end
    end
  end
end
