require 'rails'

module ActiveCharts
  class Engine < ::Rails::Engine
    initializer 'active_charts.initialize' do
      ActiveSupport.on_load(:action_view) do
        include ActiveCharts::Helpers::BarChartHelper
        include ActiveCharts::Helpers::ScatterPlotHelper
      end
    end

    config.eager_load_namespaces << ActiveCharts
  end
  
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Helpers
    autoload :Util
    autoload :Chart
    autoload :RectangularChart
    autoload :XYChart
    autoload :BarChart
    autoload :ScatterPlot
  end  
end
