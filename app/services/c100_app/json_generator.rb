module C100App
  class JSONGenerator
    delegate :to_json, to: :data

    def generate(presenter, copies:)
      data[presenter.name] = presenter.to_hash
    end

    def has_forms_data?
      false
    end

    private

    def data
      @_data ||= {}
    end
  end
end
