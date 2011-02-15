require 'inherited_resources_views/action_view'
require 'inherited_resources_views/i18n_helper'
require 'inherited_resources_views/helper'

ActionView::Base.send :include, InheritedResourcesViews::ActionView
ActionView::Base.send :include, InheritedResourcesViews::I18nHelper

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
  def self.inherited(base)
    super
    base.clear_helpers
    base.helper ::ApplicationHelper, InheritedResourcesViews::Helper
  end
end
