class PolyTreeNode

    attr_accessor :children
    attr_reader :value, :parent
    

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(parent_node)
        return if parent_node == self.parent

        if self.parent != nil
            self.parent.children.reject! {|child| child == self}
        end

        unless self.parent == parent_node
            if !(parent_node == nil)
                @parent = parent_node
                parent_node.children.push(self)
            else
                @parent = parent_node
            end
        end
    end

    def add_child(child_node)
      child_node.parent = self
    end

    def remove_child(child_node)
      raise "Not a child" if (child_node.parent == nil)
      child_node.parent = nil
    end

    def dfs(target)
        return self if target == self.value

        self.children.each do |child|
            current_stack_val = child.dfs(target)
            return current_stack_val if !(current_stack_val.nil?)
        end
        return nil if self.children.empty?
    end

    def bfs(target)
        queue = [self]
        while !queue.empty?
            shifted_val = queue.shift
            return shifted_val if shifted_val.value == target
            queue += shifted_val.children
        end
        return nil
    end

end
