
require_relative '../lib/graph'

describe Graph do

  describe '#new' do
    it "should take a hash" do
      Graph.new({})
    end

    it "should fail if the param is nil" do
      expect {
        Graph.new(nil)
      }.to raise_error
    end

    it "should fail if the param is not a hash" do
      expect {
        Graph.new(:not_a_hash)
      }.to raise_error
    end

    it "should fail if the hash is in the wrong format" do
      expect {
        Graph.new({
                    :wrong => 'format'
        })
      }.to raise_error
    end

    it "should have the vertix accessible" do
      graph = Graph.new({})
      graph.vertix
    end

    it "should have an vertix for each hash key" do
      graph = Graph.new({
                          :first_vertix => [
                            {:to => :second_vertix,	:cost => 10}
                          ],
                          :second_vertix => []
      })

      graph.vertix.should eq({
                               :first_vertix => [
                                 {:to => :second_vertix,	:cost => 10}
                               ],
                               :second_vertix => []
      })
    end

    it "should have only one vertix for each hash key" do
      graph = Graph.new({
                          :first_vertix => [
                            {:to => :second_vertix,	:cost => 10}
                          ],
                          :second_vertix => [],
                          :second_vertix => [
                            {:to => :first_vertix, :cost => 99 }
                          ]
      })

      graph.vertix.size.should eq(2)
    end
  end

end
