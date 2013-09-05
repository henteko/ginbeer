require 'time'
require File.expand_path(File.dirname(__FILE__) + '/author.rb')

class Ginbeer
  def initialize(dir, from="", to=Time.now)
    @dir = dir
    @from = from
    @from_d = nil
    if @from != ""
      @from_d = Time.parse(@from)
    end
    @to = to


    # error handling
    epath = File.expand_path(dir)
    if File.exist?(File.join(epath, '.git'))
    elsif File.exist?(epath) && (epath =~ /\.git$/)
    elsif File.exist?(epath)
      raise InvalidGitRepositoryError.new(epath)
    else
      raise NoSuchPathError.new(epath)
    end
  end

  def authors
    authors = []
    commits = `#{self.shortlog_command}` 
    commits.each_line do |line|
      line.chomp!
      /\s*(\d+)\s(.+)/ =~ line

      count = $1.to_i
      name = $2
      authors.push(Author.new(name, count))
    end

    authors.each do |author|
      logs = `#{self.log_command(author)}`

      logs.each_line do |line|
        line.chomp!
        if /file/ =~ line
          /.*(\d+) insertion.*, (\d+) deletion/ =~ line
          insertion = $1.to_i
          deletion = $2.to_i

          author.insertion += insertion
          author.deletion += deletion
        elsif /\[(.+)\]/ =~ line
          data = $1 
          data = Time.parse(data)
          break if @from_d != nil && data < @from_d # 終了
        end
      end
    end
    return authors
  end

  def cd_command
    return "cd #{@dir} &&"
  end

  def shortlog_command
    command = "#{self.cd_command} git shortlog -s --no-merges -n --before=#{@to}"
    command += " --after=#{@from}" if @from != ""
    return command
  end

  def log_command(author)
    command = "#{self.cd_command} git log --pretty=format:'[%ad]' --shortstat --author='#{author.name}' --date=short --before=#{@to}"
    return command
  end
end
