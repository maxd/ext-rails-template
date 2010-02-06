require 'spec_helper'

describe Role do
  before(:each) do
    @valid_attributes = {
      :name => ,
      :authorizable_type => ,
      :authorizable_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Role.create!(@valid_attributes)
  end
end
