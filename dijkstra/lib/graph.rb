
class Graph
  attr :vertix

  def initialize(hash)
    @vertix = {}

    hash.each do |key, value|

      valid? value

      @vertix[key] = value unless @vertix.has_key? key
    end

  end

  def valid?( value )
    unless value.empty?
      value.each do |hash|
        raise "edge does not have :to " + hash.to_s unless hash.has_key? :to
        raise "edge does not have :cost " + hash.to_s unless hash.has_key? :cost
        raise "cost is not a number " + hash[:cost].to_s unless hash[:cost].is_a? Integer
      end

    end

    return true
  end
end
