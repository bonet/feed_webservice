require 'spec_helper'

describe Category do
  
  it { should have_many(:newsfeeds) } 
  it { should respond_to(:populate_id) } 
  it { should have_index_for(:name => 1) }
  
  it { should allow_mass_assignment_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).within(2..50) }
  
  it "should have valid factory" do
    FactoryGirl.build(:category).should be_valid
    FactoryGirl.name.should_not equal nil
  end
  
  it "Category count should increment by 1" do
    lambda { 
      FactoryGirl.create(:category) 
    }.should change(Category, :count).by(1)
  end

  it ":_id should increment by 1" do
    FactoryGirl.create(:category)  # create 1 Category object first, because if no Category is initially created, the first :_id would be nil
    
    lambda { 
      FactoryGirl.create(:category) 
    }.should change{ Category.max(:_id) }.by(1)
  end

end