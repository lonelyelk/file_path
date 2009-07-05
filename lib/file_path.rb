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

  [:blockdev?, :chardev?, :directory?, :executable?, :executable_real?, :exist?,
    :file?, :grpowned?, :owned?, :pipe?, :readable?, :readable_real?, :setgid?,
    :setuid?, :size?, :socket?, :sticky?, :symlink?, :writable?, :writable_real?,
    :zero?].each do |mthd|
      class_eval <<-RUBY
        def #{mthd}
          File.#{mthd}(self)
        end
      RUBY
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
