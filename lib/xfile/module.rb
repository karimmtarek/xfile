# Spell: Open Classes
class Module
  def my_attr_reader(*attributes)
    attributes.each do |attribute|
      class_eval("def #{attribute}; @#{attribute}; end")
    end
  end
end
