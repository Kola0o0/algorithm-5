require 'graph'

# Refactor....
class Dijkstra

  def initialize (graph, from)
    raise "graph cannot be null" if graph.nil?
    raise "graph has to be a Graph" unless graph.is_a? Graph
    raise "from has to be on the Graph" unless graph.vertix.has_key? from

    #TODO check if the graph is a DAG

    @graph = graph
    @from = from

    @distances = {}
    @unvisited = []
    @previous = {}

    @graph.vertix.each do |key, value|
      @distances[key] = Float::INFINITY
      @unvisited << key
    end
    @distances[@from] = 0

    @paths = build_shortest_paths
  end

  def shortest_path (to = nil)
    return @paths if to.nil?    
    return @paths[to]
  end

  private 

  def build_shortest_paths
    node = @from

    until @unvisited.empty? or @distances[node] == Float::INFINITY
      visit node

      @unvisited = @unvisited.sort_by {|e| @distances[e]}
      node = @unvisited.first
    end

    paths = {}
    @graph.vertix.each do |to, v|
      paths[to] = {:cost => @distances[to], :path =>[]}
      t = to
      until @previous[t].nil?
        paths[to][:path].unshift t
        t = @previous[t]
      end      
    end

    return paths
  end

  def visit (node)
    @graph.vertix[node].each do |edge|
      dist = @distances[node] + edge[:cost]

      if dist < @distances[edge[:to]]
        @distances[edge[:to]] = dist
        @previous[edge[:to]] = node
      end
    end

    @unvisited.delete node
  end

end
