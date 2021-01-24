# Knights Traversal Shortest Path: Chess 

# Getting Started
1) have ruby Gems and ruby installing in your machine

# Built With 
Ruby 

# Author
Hank Chen

# DFS_BFS_class.rb file class breakdown
1) This class method creates a tree node instance that contains several helper methods that allow the user to 
    * add a child to a parent node
    * remove a child from a parent node
    * DFS (depth first search) algorithm that searches for a target node according to its target property
    * BFS (breadth first search) algorithm that searches for a target node according to its target property

# knights_traversal.rb file shortest path breakdown
**1)** This class focuses on the chess piece : Knight

**2)** Every newly initialized KnightPathFinder instance contains ALL nodes a Knight can move BETWEEN (0, 7)
    * build_main_node_move_tree method builds our tree of possible Knight Moves
    * We built this tree by:
        * creating a sub array that stores the starting_pos + all 8 possible moves a knight can make
        * check the sub array of moves with a seen (considered_positions) set so we do not repeat nodes that we have visited 
        * We return the subarray after both checks into a main queue where it begins to build our tree by creating new nodes using the PolyTreeNode class and add the nodes as children to its parent node

**3)** self.root_node, contains all child nodes that we built using the build_main_node_move_tree method

**4)** find_path method can now use either DFS or BFS to search the self.root_node and it's children to find the most optimal route to reach the target (end_pos) we gave it 
    * trace_path_back : displays an array of the path from the end_pos / node to our start_pos / node
