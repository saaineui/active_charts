require 'thor/group'

module ActiveCharts
  module Generators
    class Assets < Thor::Group
      include Thor::Actions
      
      source_root File.expand_path('../templates', __FILE__)

      def copy_stylesheets
        template 'active_charts.css.scss', 'app/assets/stylesheets/active_charts.css.scss'
        say '   - make sure to require or import it if you have customized your application.css file'
      end
      
      def copy_javascript
        template 'active_charts.js', 'app/assets/javascripts/active_charts.js'
        say '       - bundle active_charts.js in application.js by adding:
         //= require active_charts'
        say '       - if your application.js is loaded in document head, precompile the active_charts script separately by adding to config/initializers/assets.rb:
         Rails.application.config.assets.precompile += %w[active_charts.js]'
      end  
    end
  end
end
    