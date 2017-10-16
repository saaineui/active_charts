# frozen_string_literal: true

module ActiveCharts
  module Helpers #:nodoc:
    class CollectionParser
      def initialize(resource_collection, columns, label_column)
        resource = resource_collection.first.class

        @label_column = label_column || Util.label_column(resource)
        @columns = Util.valid_columns(resource, columns)
        @rows = resource_collection.pluck(@label_column)
        @collection = resource_collection.pluck(*@columns)
      end

      attr_reader :collection, :columns, :rows, :label_column

      def series_labels
        columns.map(&:to_s).map(&:titleize)
      end

      def xy_series_labels
        series_labels_size = series_labels.size.even? ? series_labels.size : series_labels.size - 1

        (0..series_labels_size - 1).step(2).map do |index|
          "#{series_labels[index]} vs. #{series_labels[index + 1]}"
        end
      end

      def xy_collection
        collection.map do |row|
          row_size = row.count.even? ? row.size : row.size - 1

          (0..row_size - 1).step(2).map do |index|
            [row[index], row[index + 1]] if row[index] && row[index + 1]
          end.compact
        end
      end
    end
    
    private_constant :CollectionParser
  end
end
