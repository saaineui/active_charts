require 'rails'
require 'active_charts/version'
require 'active_charts/chart'
require 'active_charts/rectangular_chart'
require 'active_charts/bar_chart'
require 'active_charts/scatter_plot'
require 'active_charts/helpers/chart_helper'

module ActiveCharts
  class Engine < ::Rails::Engine
    initializer 'active_charts.initialize' do
      ActiveSupport.on_load(:action_view) do
        include ActiveCharts::Helpers::ChartHelper
      end
    end

    config.eager_load_namespaces << ActiveCharts
  end
  
  extend ActiveSupport::Autoload

  autoload :Helpers
  autoload :Util
end
