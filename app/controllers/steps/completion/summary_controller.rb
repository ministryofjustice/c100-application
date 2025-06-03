module Steps
  module Completion
    class SummaryController < Steps::CompletionStepController
      def show
        presenter = Summary::PdfPresenter.new(current_c100_application)

        respond_to do |format|
          format.pdf do
            presenter.generate
            # Will render the template defined in `BasePdfForm#template`
            # i.e. `steps/completion/summary/show.pdf.erb`
            send_data(presenter.to_pdf, filename: presenter.filename)
          end

          format.html do
            presenter.generate(mode: :html)
            html = presenter.collected_forms.map do |form|
              C100App::PdfGenerator.new.send(:render, form)
            end.join("\n").html_safe

            render html: html
          end
        end
      end
    end
  end
end
