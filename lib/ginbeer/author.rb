class Author
  attr_accessor :name, :commit_count, :insertion, :deletion

  def initialize(name, commit_count)
    @name = name
    @commit_count = commit_count 
    @insertion = 0
    @deletion = 0
  end 

  def score
    return @commit_count + @insertion + @deletion
  end

  def result
    return "#{self.name}: #{self.score}(commits: #{self.commit_count}, insertion: #{self.insertion}, deletion: #{self.deletion})"
  end
end
