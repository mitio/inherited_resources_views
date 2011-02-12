require 'inherited_resources_views/action_view'
require 'inherited_resources_views/i18n_helper'

ActionView::Base.send :include, InheritedResourcesViews::ActionView
ActionView::Base.send :include, InheritedResourcesViews::I18nHelper
