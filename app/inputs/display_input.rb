class DisplayInput < SimpleForm::Inputs::Base
  # This method usually returns input's html like <input ... />
  # but in this case it returns just a value of the attribute.
  def input
    # label code from https://github.com/plataformatec/simple_form/blob/master/lib/simple_form/components/labels.rb#28
    template.label_tag(nil, label_content, label_html_options)
  end

  def additional_classes
    @additional_classes ||= [input_type].compact # original is `[input_type, required_class, readonly_class, disabled_class].compact`
  end
end

def label_content
  attributes = []
  attributes << reflection_or_attribute_name
  attributes << options[:association_label] if options[:association_label]

  attributes.inject(object) do |obj, attribute|
    obj.public_send(attribute)
  end
end