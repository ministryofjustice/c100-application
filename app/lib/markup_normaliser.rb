class MarkupNormaliser
  attr_reader :markup1, :markup2

  def initialize(markup1, markup2)
    @markup1 = markup1
    @markup2 = markup2

    normalise!
  end

  private

  def normalise!
    doc1 = Nokogiri::HTML.fragment(markup1, 'UTF-8')
    doc2 = Nokogiri::HTML.fragment(markup2, 'UTF-8')

    doc1 = remove_blank_children(doc1)
    doc2 = remove_blank_children(doc2)

    strip_autocomplete!(doc1)
    strip_autocomplete!(doc2)

    @markup1 = doc1.to_html
    @markup2 = doc2.to_html
  end

  def remove_blank_children(element)
    element.children.each do |child|
      if child.children.any?
        remove_blank_children(child)
      elsif child.blank?
        # Remove empty elements, like `#(Text "\n  ")`
        child.remove
      end
    end

    element
  end

  def strip_autocomplete!(doc)
    doc.traverse do |element|
      next unless element.element?

      if element.name == "input" && element["type"] == "hidden"
        element.remove_attribute("autocomplete")
      end
    end
  end
end
