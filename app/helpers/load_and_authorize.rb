module LoadAndAuthorize

  class RecordDiscardedError < StandardError
  end

  def load_and_authorize(model, action = :show, optional: false)
    return if optional && !(params[:"#{model}_id"] || params[:"#{model}_key"])
    instance_variable_set :"@#{model}", ModelLocator.new(model, params).locate!

    if instance_variable_get(:"@#{model}").respond_to?(:discarded?) &&
       instance_variable_get(:"@#{model}").discarded?
      raise RecordDiscardedError.new
    end

    current_user.ability.authorize! action, instance_variable_get(:"@#{model}")
  end
end
