module InheritedResourcesViews
  module I18nHelper

    def human_resource(pluralize=false)
      human = I18n.t(resource_instance_name,
                   :scope => [:activerecord, :models],
                   :default => resource_instance_name.to_s.humanize)
      pluralize ? human.pluralize : human
    end

    def human_action(action, pluralize=false)
      translate_action(:actions, action, pluralize) do |model|
        "#{action.to_s.humanize}"
      end
    end

    def action_title(action, pluralize=false)
      translate_action(:titles, action, pluralize) do |model|
        "#{action.to_s.humanize} #{model}"
      end
    end

    private
    def translate_action(prefix, action, pluralize=false)
      model = human_resource((action.to_s == 'index') || pluralize)
      instance = params[:id] ? resource : nil

      defaults = []
      defaults << :"helpers.#{prefix}.#{resource_instance_name}.#{action}"
      defaults << :"helpers.#{prefix}.#{action}"
      defaults << yield(model) if block_given?

      I18n.t(defaults.shift, :model => model, :resource => instance, :default => defaults)
    end
  end
end
