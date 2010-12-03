module YahooStock
  # == DESCRIPTION:
  # Convert results as an array of key value pairs
  # 
  # == USAGE
  # YahooStock::Result::HashFormat.new("data as string"){['array', 'of', 'keys']}.output
  # The number of keys in the block array must be equal to the values expected to be returned
  #
  # Mostly will be used as a separate strategy for formatting results
  class Result::HashFormat < Result
    
    def initialize(data, stock_symbols, &block)
      @data = YahooStock::Result::ArrayFormat.new(data).output
      @stock_symbols = stock_symbols
      @keys = yield
      super(self)
    end
    
    def output
      data = Hash.new 
      @data.each_with_index do |datum, index|
        row_values = {}
        datum.each_with_index do |item, i|
          row_values[keys[i]] = item
        end
        data[@stock_symbols[index]] = row_values
      end
      data
    end
    
    def keys
      @keys.collect{|key| key.to_s.gsub(/\s/,'_').downcase.to_sym}
    end
    
  end

  
end
