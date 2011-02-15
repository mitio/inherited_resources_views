module InheritedResourcesViews
  module I18nHelper

    # Transform the resource class name into a more human format, using I18n.
    # By default, it will underscore then humanize the class name.
    #
    #   human_resource # => "Project manager"
    #
    def human_resource(pluralize=false)
      human = I18n.t(resource_instance_name,
                   :scope => [:activerecord, :models],
                   :default => resource_instance_name.to_s.humanize)
      pluralize ? human.pluralize : human
    end

    # Transform the action name into a more human format, using I18n.
    #
    #   human_action(:show) # => "Show"
    #
    # This helper is useful when creating links:
    #
    #   <%= link_to human_action(:show), resource_url(blog) %>
    #
    # renders:
    #
    #   <a href="/blogs/1">Show</a>
    #
    def human_action(action, pluralize=false)
      translate_action(:actions, action, pluralize) do |model|
        "#{action.to_s.humanize}"
      end
    end

    # Transform the action name into a more human format for page headings, using I18n.
    #
    #   action_title(:index) # => "Listing projects"
    #
    # This helper is useful when creating page headings:
    #
    #   <h1><%= action_title(:index) %></h1>
    #
    # renders:
    #
    #   <h1>Listing projects</h1>
    #
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
