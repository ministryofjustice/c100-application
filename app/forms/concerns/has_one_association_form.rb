module HasOneAssociationForm
  extend ActiveSupport::Concern

  module ClassMethods
    attr_accessor :association_name

    def build(c100_application:)
      super(record(c100_application), c100_application: c100_application)
    end

    def record(parent)
      parent.public_send(association_name) || parent.public_send("build_#{association_name}")
    end

    private

    def has_one_association(name)
      self.association_name = name
    end
  end

  private

  def record
    @_record ||= self.class.record(c100_application)
  end
end
