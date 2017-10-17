# frozen_string_literal: true

module ActiveCharts
  module Helpers #:nodoc:
    class CollectionParser
      def initialize(resource_collection, columns, label_column)
        resource = resource_collection.first.class

        @label_column = label_column || auto_label_column(resource)
        @columns = valid_columns(resource, columns)
        @rows = resource_collection.pluck(@label_column)
        @collection = resource_collection.pluck(*@columns)
      end

      attr_reader :collection, :columns, :rows, :label_column

      def series_labels
        columns.map(&:to_s).map(&:titleize)
      end

      def xy_series_labels
        x_label = series_labels.first

        series_labels[1..-1].map do |y_label|
          "#{x_label} vs. #{y_label}"
        end
      end

      def xy_collection
        collection.map do |row|
          x_val = row.first

          row[1..-1].map do |y_val|
            [x_val, y_val]
          end
        end
      end
      
      private
      
      def valid_columns(resource, columns)
        attribute_names = resource.new.attribute_names.map(&:to_sym) 

        return attribute_names if columns.eql?([])

        attribute_names & columns
      end

      def auto_label_column(resource)
        attribute_names = resource.new.attribute_names

        %w[name title id].each do |attribute_name|
          return attribute_name.to_sym if attribute_names.include?(attribute_name)
        end

        attribute_names.first.to_sym
      end
    end
    
    private_constant :CollectionParser
  end
end
