require 'thor'
require 'active_charts/generators/assets'

module ActiveCharts
  class CLI < Thor
    desc 'install', 'Installs Active Record and generates the default asset files'

    def install
      ActiveCharts::Generators::Assets.start
    end
  end
end
