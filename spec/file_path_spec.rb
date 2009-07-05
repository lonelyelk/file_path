require File.join(File.dirname(__FILE__), "..", "lib", "file_path.rb")

describe FilePath do
  it "should show correct current path" do
    FilePath.current.should == File.expand_path(File.dirname(__FILE__))
  end
end
