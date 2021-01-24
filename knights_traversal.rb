require_relative './DFS_BFS_class.rb'
require 'set'

class KnightPathFinder
    attr_reader :start_pos    
    attr_accessor :root_node, :considered_positions

    MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
    ]

    def self.valid_moves(pos)
        valid_moves = []
        cx, cy = pos

        MOVES.each do |(x , y)|
            new_pos = [cx + x, cy + y]

            if new_pos.all? {|pos| pos.between?(0, 7)}
                valid_moves << new_pos
            end
        end

        valid_moves
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = Set.new{[[start_pos]]}

        build_main_node_move_tree
    end

    def valid_new_moves_after_considered_check(pos)
        potential_valid_moves = KnightPathFinder.valid_moves(pos)
        true_valid_moves = []
        
        potential_valid_moves.each do |move|
            if !self.considered_positions.include?(move)
                self.considered_positions << move
                true_valid_moves << move
            end
        end
        true_valid_moves
    end

    def build_main_node_move_tree
        # All potential nodes we create can be referenced from self.root_node, they are all children of this node
        self.root_node = PolyTreeNode.new(self.start_pos)
        queue = [self.root_node]

        until queue.empty?
            shifted_node = queue.shift
            shifted_val = shifted_node.value
            valid_new_moves_after_considered_check(shifted_val).each do |new_pos|
                new_node = PolyTreeNode.new(new_pos)
                shifted_node.add_child(new_node)
                queue.concat([new_node])
            end
        end
    end

    def find_path(end_pos)
        # we found end_node using dfs shortest path search
        end_node = self.root_node.dfs(end_pos)

        # trace_path_back will display an array of the path from end_node to root_node
        shortest_path_from_end_node = trace_path_back(end_node)

        # for readability purposes as we only want to display value property of each node
        shortest_path_from_end_node.reverse.map(&:value)
    end

    def trace_path_back(end_node)
        shortest_path_back_to_root_nodes = []

        # we create a copy of end_node because we do not want to mess with the actual end_node reference
        current_node = end_node
        # Reason why our loop stops at current_node == nil? is because we initialized 
        # our start_nodes @parent as nil. So when we root the root_node we can stop the until loop 
        # and return the path from the found node back to the route
        until current_node.nil?
            shortest_path_back_to_root_nodes << current_node
            # call current_node's parent to retrace back the tree/graph
            current_node = current_node.parent
        end

        shortest_path_back_to_root_nodes

    end

end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    p kpf.find_path([3,3])
end
