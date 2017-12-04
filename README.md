# ActiveCharts

Beautiful, easy charts for ActiveRecord and Rails.

[![View on Travis](https://travis-ci.org/saaineui/active_charts.svg?branch=master)](https://travis-ci.org/saaineui/active_charts)

ActiveCharts is a charting toolset that integrates into ActiveRecord and ActionView for fast, easy business intelligence and data visualization on any Rails app. 

ActiveCharts uses inline SVG wherever possible for simplicity and best performance on the web. Javascript is used only when absolutely necessary.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_charts'
```

And then execute:

    $ bundle install

Generate the default stylesheet and script files:

    $ bundle exec active_charts install
    
Follow the command line instructions to include the files in your assets pipeline.

## Usage

ActiveCharts autoloads its view helpers into your Rails app. For every chart type available, there are helpers for raw data (array of arrays) and for ActiveRecord collections.

### Chart Gallery

You can view sample charts created with the latest version of ActiveCharts at the Chart Gallery: 
 - [Chart Gallery](https://necker.herokuapp.com/active_charts "ActiveCharts Chart Gallery")

### [Bar Charts](https://necker.herokuapp.com/active_charts#bar-charts)

#### `bar_chart(collection, options = {})`

ActiveCharts helpers all support multi-series data by default, so each 'row' of data should be wrapped in an array even if you are creating a single-series chart, e.g. `[[1], [2], [3]]` is a single-series data set with three datapoints.

If you do have multiple series, include the columns in the same order in each row. `[[1, 2], [2, 4], [3, 9]]` is a valid multi-series data set for use with the `bar_chart` helper.

_Note: ActiveCharts does not currently support negative values in its Bar Charts, but will in the future. Both Line Charts and Scatter Plots support all real numbers._

```ruby
# controller:
@collection = [[a1, b1, c1], [a2, b2, c2], ... [a50, b50, c50]]
@rows = ['Alabama', 'Alaska', ... 'Wyoming']
@series_labels = ['Median Income', 'Percent White', 'GDP Per Capita']

# view:
<%= bar_chart(@collection, title: 'Census Data by State', rows: @rows, series_labels: @series_labels) %>
```

#### `bar_chart_for(resource_collection, columns, options = {})`

If you have an ActiveRecord model named State with columns named `:median_income`, `:percent_white`, and `:gdp_per_capita` that correspond to the same series as in the above example, you will get a similar chart with the following code in your view. ActiveCharts will automatically use the `:name` column to populate the rows array. Manual methods for setting rows are described below.

```ruby
# view:
<%= bar_chart_for(State.all, [:median_income, :percent_white, :gdp_per_capita], title: 'Census Data by State') %>
```

#### Options

All charts have the following options unless indicated otherwise:

 - `:title` - Specifies a string to include in the `<figcaption>` element as the chart title. Default is “” (i.e. nothing).
 - `:class` - Specifies a string to append to the CSS class for the `<figure>` element which contains the chart title, svg data, and legend.  Default is “” (i.e. nothing).
 - `:data_formatters` - Specifies an array of symbols for special formatting of data columns. If not set, all data will be floating point numbers formatted using the `number_with_delimiter` helper.
    - Available formatters are: `:percent`, `:date`, `:currency`, `:rounded`, `:none`.
 - `:max_values` - Specifies an array of max y values for each data column, in column order (e.g. [300000, 1, 300000] might be passed for the above example, if we want Median Income and GDP Per Capita rendered using the same scale). Default will be the largest value in each column, as calculated by ActiveCharts.
 - `:single_y_scale` - Set to true if you want to force a single y scale across all of your columns. (Note: if `:max_values` is set to valid data, it will override this setting.)
 - `:series_labels` - Specifies an array of strings to use in the legend. (Default on basic helpers is []. Default on `_for` helpers is an array of column names.)
 - `:label_height` - Specifies the number of pixels high the chart text labels should be. (Default is 10.) 

All rectangular charts (Bar Charts, Scatter Plots, and Line Charts) have the following options unless indicated otherwise:

 - `:height` - Specifies the number of pixels high the chart should be. (Default is 400.)
 - `:rows` - Specifies an array of strings to use to label bars or datapoints.  Default is [] (i.e. nothing).
 
Bar Charts have the following additional options:

 - `:bar_width` - Specifies the number of pixels wide each bar should be. (Default is 40.) Width is automatically calculated from `:bar_width`.
 
### XY Charts in ActiveCharts: Scatter Plots and Line Charts
 
ActiveCharts supports two types of charts that plot data on an XY grid: Scatter Plots and Line Charts. Each datapoint in these charts is represented by a two-item array, with the x value in the 0 position and the y value in the 1 position: `[x, y]`.

Use these charts to plot time-series data or to visualize the relationship between two variables.

`[[[1, 1.1]], [[2, 1.9]], [[3, 3.6]]]` is a valid single-series Scatter Plot or Line Chart data set with three datapoints (note the extra array wrapping each row is still required). 

For multiple series, again include the columns in the same order in each row. `[[[1, 1.1], [3, 5]], [[2, 1.9], [0, 7]]]` is a valid multi-series data set for use with the `scatter_plot` and `line_chart` helpers.

### [Scatter Plots](https://necker.herokuapp.com/active_charts#scatter-plots)

In the following examples, we plot `:median_income` vs. `:gdp_per_capita` for each state.

#### `scatter_plot(collection, options = {})`

```ruby
# controller:
@collection = [[[x1, y1]], [[x2, y2]], ... [[x50, y50]]]
@rows = ['Alabama', 'Alaska', ... 'Wyoming']
@series_labels = ['Median Income', 'GDP Per Capita']

# view:
<%= scatter_plot(@collection, title: 'Census Data by State', rows: @rows, series_labels: @series_labels) %>
```

#### `scatter_plot_for(resource_collection, columns, options = {})`

The ActiveRecord model helper `scatter_plot_for` works similarly to `bar_chart_for`. This code will produce a similar chart to the above example.

```ruby
# view:
<%= scatter_plot_for(State.all, [:median_income, :gdp_per_capita], title: 'Census Data by State') %>
```

A big difference to be aware of with `scatter_plot_for` and `line_chart_for` is that these XY helpers only support one column as the source for the x axis data (e.g. _a_ vs. _b_ and _a_ vs. _c_). If you wish to plot _a_ vs. _b_ and _c_ vs. _d_, you will need to use the generic helpers `scatter_plot` and `line_chart`.

The first column specified in the `columns` array is the x value for all data points for the row, and the remaining columns will be the y value(s).

The following will print each state's median income vs. the % of its population that's white in a series of red dots, and the median income vs. its GDP per capita in a series of orange dots. 

```ruby
# view:
<%= scatter_plot_for(State.all, [:median_income, :percent_white, :gdp_per_capita], title: 'Census Data by State') %>
```

#### Options

Both XY Charts (Scatter Plots and Line Charts) have the following options unless indicated otherwise:

 - `:width` - Specifies the number of pixels high the chart should be. (Default is 600.)

### [Line Charts](https://necker.herokuapp.com/active_charts#line-charts)

Line Chart helpers work almost exactly the same as Scatter Plot helpers. Please review the previous section for detailed instructions.

_Note: The path for each series will be drawn in the given order, so please sort your collection in X order before passing it to `line_chart` or `line_chart_for` or your line will be crooked._

#### `line_chart(collection, options = {})`

```ruby
# controller:
@collection = [[[x1, y1]], [[x2, y2]], ... [[x50, y50]]]
@rows = ['Alabama', 'Alaska', ... 'Wyoming']
@series_labels = ['Median Income', 'GDP Per Capita']

# view:
<%= line_chart(@collection, title: 'Census Data by State', rows: @rows, series_labels: @series_labels) %>
```

#### `line_chart_for(resource_collection, columns, options = {})`

```ruby
# view:
<%= line_chart_for(State.all.order(:name), [:median_income, :gdp_per_capita], title: 'Census Data by State') %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 

Then, run the tests:

    $ bundle exec rspec
    $ bundle exec cucumber
    $ bundle exec rake jasmine

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saaineui/active_charts. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveCharts project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/saaineui/active_charts/blob/master/CODE_OF_CONDUCT.md).
