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
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 600px; height: auto;" viewBox="0 0 600 410" class="ac-chart ac-scatter-plot">#{grid_rect_tag(390, 560)}
          <circle cx="448.0" cy="292.5" class="ac-scatter-plot-dot series-a" />
          <text x="448.0" y="292.5" class="ac-scatter-plot-label">cats</text>
          <circle cx="336.0" cy="390.0" class="ac-scatter-plot-dot series-b" />
          <text x="336.0" y="390.0" class="ac-scatter-plot-label">cats</text>
          <circle cx="112.0" cy="97.5" class="ac-scatter-plot-dot series-a" />
          <text x="112.0" y="97.5" class="ac-scatter-plot-label">dogs</text>
          <text x="580" y="390.0" class="ac-y-label">0</text><text x="580" y="292.5" class="ac-y-label">1</text><text x="580" y="195.0" class="ac-y-label">2</text><text x="580" y="97.5" class="ac-y-label">3</text><text x="580" y="0.0" class="ac-y-label">4</text>
          <text x="0.0" y="405.0">1</text><text x="112.0" y="405.0">2</text><text x="224.0" y="405.0">3</text><text x="336.0" y="405.0">4</text><text x="448.0" y="405.0">5</text><text x="560.0" y="405.0">6</text></svg>
          <ul class="ac-chart ac-series-legend"><li class="series-a">Floor 1</li><li class="series-b">Floor 2</li></ul></figure>)
  end
  
  def scatter_plot_empty
    %(<figure class="ac-chart-container ac-clearfix "><figcaption class="ac-chart-title"></figcaption>
          <svg xmlns="http://www.w3.org/2000/svg" style="width: 600px; height: auto;" viewBox="0 0 600 400" class="ac-chart ac-scatter-plot">#{grid_rect_tag(380, 560)}
          <text x="580" y="380.0" class="ac-y-label">0</text><text x="580" y="0.0" class="ac-y-label">1</text>
          <text x="0.0" y="395.0">0</text><text x="560.0" y="395.0">1</text></svg>
          <ul class="ac-chart ac-series-legend"></ul></figure>)
  end
  
  def grid_rect_tag(height, weight)
    offset = TOP_LEFT_OFFSET * 2
    %(<rect x="1" y="1" height="#{height - offset}" width="#{weight - offset}" class="grid"></rect>)
  end
  
  module_function :bar_chart, :bar_chart_empty, :scatter_plot, :scatter_plot_empty, :grid_rect_tag
end
