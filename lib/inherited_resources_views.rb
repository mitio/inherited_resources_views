require 'inherited_resources_views/action_view'
require 'inherited_resources_views/i18n_helper'
require 'inherited_resources_views/helper'

# Clears up all existing helpers in this class, only keeping
# the helper with the same name as this class, ApplicationHelper
# and InheritedResourcesViews::Helper.
#
# By default, in Rails 3, if you derive your class from
# ActionController::Base, all helpers will be included.
# Since InheritedResourcesViews::Helper module relies on different
# helpers using the same method names, this is a very bad thing.
#
class InheritedResources::Base
  instance_eval do
    alias :inherit_resources_original :inherit_resources
  end

  def self.inherit_resources(base)
    inherit_resources_original(base)
    include_helpers(base)
  end

  def self.inherited(base)
    super
    include_helpers(base)
  end

  private
  def self.include_helpers(base)
    base.class_eval do
      clear_helpers
      helper ::ApplicationHelper,
        InheritedResourcesViews::I18nHelper,
        InheritedResourcesViews::Helper

      helper_method :action_defined?
      private
        def action_defined?(action)
          respond_to? action and respond_to? "#{action}!"
        end
    end
  end
end
