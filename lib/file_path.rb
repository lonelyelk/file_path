class FilePath < String
  # Creates new file path. If path is not given, dirname of current file
  # is taken
  def initialize(path = nil)
    if path
      replace expand(path)
    else
      replace expand(File.dirname(caller(1)[0].split(":")[0]))
    end
  end

  # Joins string or filepath into new path
  # Example:
  #   FilePath.new("somedir")/"other_dir"/"file"     => "somedir/other_dir/file"
  def /(other)
    FilePath.new(expand(File.join(self, other)))
  end

  class << self
    # Expanded path to current file: File.expand_path(__FILE__)
    def current
      new(caller(1)[0].split(":")[0])
    end
  end

protected

  def expand(path)
    File.expand_path(path)
  end
end
