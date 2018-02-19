class MiamExemptionsPresenter < SimpleDelegator
  Exemption = Struct.new(:group_name, :collection) do
    def show?
      collection.any?
    end

    def to_partial_path
      'steps/miam_exemptions/shared/exemption'
    end
  end

  def exemptions
    return [] unless __getobj__

    exemption_groups.map do |group|
      Exemption.new(group, filtered(self[group]))
    end.select(&:show?)
  end

  def exemption_groups
    [:domestic, :protection, :urgency, :adr, :misc].freeze
  end

  private

  # We filter out `group_xxx` items, as the purpose of these are to present the exemptions
  # in groups for the user to show/hide them, and are not really an exemption by itself.
  #
  # Also we filter out the `xxx_none` because it means this exemptions group doesn't apply
  # to the user (none of the exemptions were selected, so nothing to playback).
  #
  def filtered(collection)
    collection.grep_v(/^group_|_none$/)
  end
end
