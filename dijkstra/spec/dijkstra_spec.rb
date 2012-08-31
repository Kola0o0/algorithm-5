
require_relative '../lib/dijkstra'

describe Dijkstra do

  describe '#new' do
    it 'should take a graph' do
      Dijkstra.new(Graph.new({:in_graph => []}), :in_graph)
    end

    it 'should fail if the graph is nil' do
      expect {
        Dijkstra.new(nil, :from)
      }.to raise_error
    end

    it 'should fail if from is not in the graph' do
      expect {
        Dijkstra.new(Graph.new({:in_graph => []}), :not_in_graph)
      }.to raise_error
    end

    it 'should fail if it is not a graph' do
      expect {
        Dijkstra.new(:not_a_graph, nil)
      }.to raise_error
    end
  end

  describe '#shortest_path' do
    it 'should give the shortest path between two vertix' do
      graph = Graph.new({
                          :a => [
                            {:to => :b, :cost => 3},
                            {:to => :c, :cost => 20},
                            {:to => :d, :cost => 10}
                          ],
                          :b => [
                            {:to => :d, :cost => 1}
                          ],
                          :c => [
                            {:to => :e, :cost => 5}
                          ],
                          :d => [
                            {:to => :e, :cost => 2}
                          ],
                          :e => []
      })

      Dijkstra.new(graph, :a).shortest_path(:e).should eq({
                                                            :cost => 6,
                                                            :path => [:b, :d, :e]
      })
    end

    it 'should give the shortest path from a vertix to all others' do
      graph = Graph.new({
                          :a => [
                            {:to => :b, :cost => 3},
                            {:to => :c, :cost => 20},
                            {:to => :d, :cost => 10}
                          ],
                          :b => [
                            {:to => :d, :cost => 1}
                          ],
                          :c => [
                            {:to => :e, :cost => 5}
                          ],
                          :d => [
                            {:to => :e, :cost => 2}
                          ],
                          :e => []
      })

      Dijkstra.new(graph, :a).shortest_path.should eq({
                                                        :a => {:cost => 0,
                                                               :path => []},
                                                        :b => {:cost => 3,
                                                               :path => [:b]},
                                                        :c => {:cost => 20,
                                                               :path => [:c]},
                                                        :d => {:cost => 4,
                                                               :path => [:b, :d]},
                                                        :e => {:cost => 6,
                                                               :path => [:b, :d, :e]},
      })
    end
  end
end
