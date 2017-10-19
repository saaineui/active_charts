module SVGChart
  TOP_LEFT_OFFSET = 1
  
  def bar_chart
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title">Pets per Floor</figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 280px; height: auto;" viewBox="0 0 280 410" class="ac-chart ac-bar-chart">#{grid_rect_tag(390, 280)}
          <rect height="360.0" x="20" y="30.0" class="ac-bar-chart-bar series-a" width="40" />
          <text x="40" y="25.0">5</text>
          <rect height="120.0" x="80" y="270.0" class="ac-bar-chart-bar series-b" width="40" />
          <text x="100" y="265.0">1</text>
          <rect height="144.0" x="160" y="246.0" class="ac-bar-chart-bar series-a" width="40" />
          <text x="180" y="241.0">2</text>
          <rect height="360.0" x="220" y="30.0" class="ac-bar-chart-bar series-b" width="40" />
          <text x="240" y="25.0">3</text>
          <text x="70.0" y="405.0">cats</text><text x="210.0" y="405.0">dogs</text></svg>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1</li><li class="series-b">Floor 2</li></ul></figure>)
  end

  def bar_chart_empty
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title"></figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 20px; height: auto;" viewBox="0 0 20 400" class="ac-chart ac-bar-chart">#{grid_rect_tag(380, 20)}
          </svg>
          <ul class="ac-chart ac-series-legend"></ul></figure>)
  end
  
  def scatter_plot
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title">Pets per Floor</figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 600px; height: auto;" viewBox="0 0 600 410" class="ac-chart ac-scatter-plot"><rect x="1" y="1" height="388" width="518" class="grid"></rect>
          <line x1="104.0" x2="104.0" y1="1" y2="389" class="ac-grid-line" />
          <line x1="208.0" x2="208.0" y1="1" y2="389" class="ac-grid-line" />
          <line x1="312.0" x2="312.0" y1="1" y2="389" class="ac-grid-line" />
          <line x1="416.0" x2="416.0" y1="1" y2="389" class="ac-grid-line" />
          <line x1="1" x2="519" y1="292.5" y2="292.5" class="ac-grid-line" />
          <line x1="1" x2="519" y1="195.0" y2="195.0" class="ac-grid-line" />
          <line x1="1" x2="519" y1="97.5" y2="97.5" class="ac-grid-line" />
          <circle cx="416.0" cy="292.5" class="ac-scatter-plot-dot ac-triggerable series-a" />
          <text x="422.0" y="286.5" class="ac-scatter-plot-label ac-toggleable">cats</text>
          <circle cx="416.0" cy="390.0" class="ac-scatter-plot-dot ac-triggerable series-b" />
          <text x="422.0" y="384.0" class="ac-scatter-plot-label ac-toggleable">cats</text>
          <circle cx="104.0" cy="97.5" class="ac-scatter-plot-dot ac-triggerable series-a" />
          <text x="110.0" y="91.5" class="ac-scatter-plot-label ac-toggleable">dogs</text>
          <circle cx="104.0" cy="390.0" class="ac-scatter-plot-dot ac-triggerable series-b" />
          <text x="110.0" y="384.0" class="ac-scatter-plot-label ac-toggleable">dogs</text>
          <text x="526" y="390.0" class="ac-y-label">0</text><text x="526" y="292.5" class="ac-y-label">1</text><text x="526" y="195.0" class="ac-y-label">2</text><text x="526" y="97.5" class="ac-y-label">3</text><text x="526" y="11" class="ac-y-label">4</text>
          <text x="0.0" y="405.0" class="ac-x-label anchor_start">1</text><text x="104.0" y="405.0" class="ac-x-label">2</text><text x="208.0" y="405.0" class="ac-x-label">3</text><text x="312.0" y="405.0" class="ac-x-label">4</text><text x="416.0" y="405.0" class="ac-x-label">5</text><text x="520.0" y="405.0" class="ac-x-label">6</text></svg>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1 vs. Floor 2</li><li class="series-b">Floor 1 vs. Floor 3</li></ul></figure>)
  end
  
  def xy_chart_empty(width = 600, height = 400, class_name = 'scatter-plot')
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title"></figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: #{width}px; height: auto;" viewBox="0 0 #{width} #{height}" class="ac-chart ac-#{class_name}">#{grid_rect_tag(height - 20, width - 80)}
          <text x="526" y="380.0" class="ac-y-label">0</text><text x="526" y="11" class="ac-y-label">1</text>
          <text x="0.0" y="395.0" class="ac-x-label anchor_start">0</text><text x="520.0" y="395.0" class="ac-x-label">1</text></svg>
          <ul class="ac-chart ac-series-legend"></ul></figure>)
  end
  
  def xy_chart_x_labels
    %(<text x="0.0" y="490.0" class="ac-x-label anchor_start">-$4</text><text x="62.0" y="490.0" class="ac-x-label">-$3</text><text x="124.0" y="490.0" class="ac-x-label">-$2</text>)
  end
  
  def xy_date_chart_x_labels
    %(<text x="0.0" y="395.0" class="ac-x-label anchor_start">2015-10-04</text><text x="104.0" y="395.0" class="ac-x-label">2016-01-12</text><text x="208.0" y="395.0" class="ac-x-label">2016-04-21</text><text x="312.0" y="395.0" class="ac-x-label">2016-07-30</text><text x="416.0" y="395.0" class="ac-x-label">2016-11-07</text><text x="520.0" y="395.0" class="ac-x-label">2017-02-15</text>)
  end
  
  def line_chart
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title">Pets per Floor</figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 600px; height: auto;" viewBox="0 0 600 400" class="ac-chart ac-line-chart"><rect x="1" y="1" height="378" width="518" class="grid"></rect>
          <line x1="104.0" x2="104.0" y1="1" y2="379" class="ac-grid-line" />
          <line x1="208.0" x2="208.0" y1="1" y2="379" class="ac-grid-line" />
          <line x1="312.0" x2="312.0" y1="1" y2="379" class="ac-grid-line" />
          <line x1="416.0" x2="416.0" y1="1" y2="379" class="ac-grid-line" />
          <line x1="1" x2="519" y1="285.0" y2="285.0" class="ac-grid-line" />
          <line x1="1" x2="519" y1="190.0" y2="190.0" class="ac-grid-line" />
          <line x1="1" x2="519" y1="95.0" y2="95.0" class="ac-grid-line" />
          <path d="M416.0 285.0 L 104.0 95.0" class="ac-line-chart-line series-a"></path>
          <path d="M416.0 380.0 L 104.0 380.0" class="ac-line-chart-line series-b"></path>
          <text x="422.0" y="279.0" class="ac-line-chart-label ac-toggleable">cats</text>
          <text x="110.0" y="89.0" class="ac-line-chart-label ac-toggleable">dogs</text>
          <text x="422.0" y="374.0" class="ac-line-chart-label ac-toggleable">cats</text>
          <text x="110.0" y="374.0" class="ac-line-chart-label ac-toggleable">dogs</text>
          <text x="526" y="380.0" class="ac-y-label">0</text><text x="526" y="285.0" class="ac-y-label">1</text><text x="526" y="190.0" class="ac-y-label">2</text><text x="526" y="95.0" class="ac-y-label">3</text><text x="526" y="11" class="ac-y-label">4</text>
          <text x="0.0" y="395.0" class="ac-x-label anchor_start">1</text><text x="104.0" y="395.0" class="ac-x-label">2</text><text x="208.0" y="395.0" class="ac-x-label">3</text><text x="312.0" y="395.0" class="ac-x-label">4</text><text x="416.0" y="395.0" class="ac-x-label">5</text><text x="520.0" y="395.0" class="ac-x-label">6</text></svg>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1 vs. Floor 2</li><li class="series-b">Floor 1 vs. Floor 3</li></ul></figure>)
  end
  
  def grid_rect_tag(height, width)
    offset = TOP_LEFT_OFFSET * 2
    %(<rect x="1" y="1" height="#{height - offset}" width="#{width - offset}" class="grid"></rect>)
  end
  
  module_function :bar_chart, :bar_chart_empty, 
                  :scatter_plot, 
                  :line_chart, 
                  :xy_chart_empty, :xy_chart_x_labels, :xy_date_chart_x_labels, 
                  :grid_rect_tag
end
