require 'active_support/concern'

module SortableTreeController
  module Sort
    extend ActiveSupport::Concern

    included do
      helper SortableTreeHelper
    end

    module ClassMethods

      def sortable_tree(class_name, options = {})
        define_method("sort") do
          resource_class = class_name.to_s.camelize.constantize

          # options
          #options[:tree] = true

          sorting_attribute = options.fetch(:sorting_attribute, 'pos')
          parent_method = options.fetch(:parent_method, 'parent')
          #options[:sorting_attribute] ||= 'pos'
          #options[:parent_method] ||= 'parent'

          records = params[:cat].to_unsafe_h.inject({}) do |res, (resource, parent_resource)|
            res[resource_class.find(resource)] = resource_class.find(parent_resource) rescue nil
            res
          end

          errors = []
          ActiveRecord::Base.transaction do
            records.each_with_index do |(record, parent_record), position|

              if sorting_attribute
                record.send "#{sorting_attribute}=", position
              end

              if parent_method
                record.send "#{parent_method}=", parent_record
              end

              errors << {record.id => record.errors} if !record.save
            end
          end

          #
          if errors.empty?
            head 200
          else
            render json: errors, status: 422
          end


        end
      end
    end



  end
end
