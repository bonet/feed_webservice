def get_category_id(component)
  category_list = { :category_art => "Art",
                    :category_science => "Science",
                    :category_business => "Business",
                    :category_tech => "Technology",
                  }
  
  return nil if category_list[component].nil?
       
  cat = Category.where(name: category_list[component]).first
  if !cat.nil?
    cat._id
  else
    FactoryGirl.create(component)._id 
  end

  
end

def get_publisher_id(component) 
  publisher_list = { :publisher_nyt => "New York Times",
                     :publisher_wash => "Washington Post",
                     :publisher_tc => "TechCrunch"
                   }
                   
  return nil if publisher_list[component].nil?
         
  pub = Publisher.where(name: publisher_list[component]).first
  if !pub.nil?
    pub._id
  else
    FactoryGirl.create(component)._id 
  end
end