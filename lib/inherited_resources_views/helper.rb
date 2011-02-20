module InheritedResourcesViews
  module Helper
    extend ActiveSupport::Concern

    module InstanceMethods

      def fields
        resource_class.column_names - hidden_fields
      end

      def hidden_fields
        %w(id created_at updated_at)
      end

      def index_fields
        fields
      end

      def show_fields
        fields
      end

      def form_fields
        fields
      end

      def display_field(resource, field)
        if respond_to?(helper = "#{field}_display")
          send(helper, resource)
        else
          default_display_field(resource, field)
        end
      end

      def form_field(form, resource, field)
        if respond_to?(helper = "#{field}_form_field")
          send(helper, form, resource)
        else
          default_form_field(form, resource, field)
        end
      end

      protected

        def default_display_field(resource, field)
          case column_type(resource, field)
          when :string
            field.include?('password') ? '******' : resource.send(field)
          when :text, :integer, :boolean
            resource.send(field)
          when :float, :decimal
            number_with_precision(resource.send(field))
          when :date, :time, :datetime, :timestamp
            I18n.l(resource.send(field))
          else
            resource.send(field)
          end
        end

        def default_form_field(form, resource, field)
          case column_type(resource, field)
          when :string
            field.include?('password') ? form.password_field(field) : form.text_field(field)
          when :text
            form.text_area(field)
          when :integer, :float, :decimal
            form.text_field(field)
          when :date
            form.date_select(field)
          when :datetime, :timestamp
            form.datetime_select(field)
          when :time
            form.time_select(field)
          when :boolean
            form.check_box(field)
          else
            form.text_field(field)
          end
        end

      private

        def column_type(resource, field)
          resource.column_for_attribute(field).type
        end
    end

    module ClassMethods

      # Defines which fields to use on views.
      #
      #   fields :title, :body, :category, :comments
      #   fields :all, :except => :comments
      #
      # or on specific views (index, show, form):
      #
      #   index_fields :title, :category
      #   show_fields :all
      #   form_fields :all, :except => :comments
      #
      # or which fields must be hidden:
      #
      #   hidden_fields :id, :created_at, :updated_at
      #
      # Hidden fields also can be used on +:except+ option,
      # which is very useful when using the +:all+ option:
      #
      #   fields :title, :body, :category, :comments
      #   show_fields :all # show all fields including the hidden ones (id, created_at and updated_at).
      #   index_fields :all, :except => [:hidden, :body, :comments] # just show both title and category fields.
      #
      instance_eval do
        InstanceMethods.instance_methods.select {|method| method.ends_with?('fields')}.each do |method|
          define_method(method) do |*fields|
            define_method(method) do
              raise ArgumentError, 'Wrong number of arguments. You have to provide which fields you want to use.' if fields.empty?
              options = fields.extract_options!
              fields = resource_class.column_names.map(&:to_sym) if fields.first == :all
              fields_to_hide = Array(options[:except])
              fields_to_hide += hidden_fields.map(&:to_sym) if fields_to_hide.delete(:hidden)
              fields_to_hide.map!(&:to_sym).uniq!
              fields -= fields_to_hide
              fields.map(&:to_s)
            end
          end
        end
      end

      # Creates helper methods from FormHelpers.
      #
      #   module PostsHelper
      #     text_field :title, :class => 'strong'
      #     text_area :body
      #     collection_select :category_id, Category.all, :id, :name
      #   end
      #
      # From the above code, will be created the following methods:
      # title_form_field, body_form_field and category_id_form_field.
      #
      def method_missing(method_name, *args)
        field = args.first

        define_method("#{field}_form_field") do |form, resource|
          if form.respond_to? method_name
            form.send(method_name, *args)
          else
            raise NoMethodError, "This form builder doesn't respond to #{method_name}"
          end
        end
      end
    end
  end
end
