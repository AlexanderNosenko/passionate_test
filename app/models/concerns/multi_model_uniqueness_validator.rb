class MultiModelUniquenessValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if options[:against].exists?(["#{attribute} = ?", value])
      record.errors[attribute] << :taken
    end
  end

end
