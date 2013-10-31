# CategoriesPerPublisher list all existing categories grouped by publisher; it can be used for navigation menu

class CategoriesPerPublisher
  
  include Mongoid::Document
  
  field :namelist
  
  def self.cron_update_categories_per_publisher

    namelist = {}
    
    self.delete_all # reset the list

    Publisher.all.each do |publisher|
      
      Newsfeed.where(:publisher_id => publisher._id).each do |newsfeed|
        
        if namelist[publisher._id].nil?
          namelist[publisher._id]  = {  :publisher_id => publisher._id, 
                                        :publisher_name => publisher.name, 
                                        :categories => []
                                     }
        end

        namelist[publisher._id][:categories] << {  :newsfeed_id => newsfeed._id, 
                                                   :category_id => newsfeed.category_id, 
                                                   :category_name => Category.find(newsfeed.category_id).name
                                                }
      end
      
    end

    self.create(:namelist => namelist)

  end
end