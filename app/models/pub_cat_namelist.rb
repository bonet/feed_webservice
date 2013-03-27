#
# PubCatNamelist Class
#
# Description:
# PubCatNamelist is a list of all Publishers (1st level) and Categories for each Publisher (2nd Level), so it's filter by Publisher.
# This is used e.g. during signup where the user needs to see all available Feed Publishers and Categories.
#
# Author: Bonet Sugiarto
# Date: 3/21/2013
#

class PubCatNamelist
  
  include Mongoid::Document
  
  field :namelist
  
  
  # This is to update available PubCats, i.e. admin might have added one or more PubCats; running this update will sync PubCatNamelist with all existing PubCats
  def self.cron_update_pub_cat_namelist

    n = {}
    
    self.delete_all

    Publisher.all.each do |pub|
      PubCat.where(:publisher_id => pub._id).each do |pubcat|
        n[pub._id]  = {:publisher_id => pub._id, :publisher_name => pub.name, :categories => []} if n[pub._id] .nil?
        n[pub._id][:categories] << {:pub_cat_id => pubcat._id, :category_id => pubcat.category_id, :category_name => Category.find(pubcat.category_id).name}
      end
      
    end

    self.create(:namelist => n)

  end
end