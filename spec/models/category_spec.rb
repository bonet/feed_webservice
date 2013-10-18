require 'spec_helper'

describe Category do
  it { should have_many(:newsfeeds) } 
  it { should respond_to(:populate_id) } 
  
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).within(2..50) }
end
