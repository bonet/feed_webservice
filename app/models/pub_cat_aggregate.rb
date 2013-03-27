#
# PubCatAggregate Class
#
# Description: 
# PubCatAggregate is a collection of PubCatAggregatePublishers and PubCatAggregateCategories.
# This is to facilitate filtering by Publisher or Category. In PubCatAggregatePublishers, all PubCats are grouped by publisher.
# The same thing also applies for PubCatAggregateCategories.
# 
# Author: Bonet Sugiarto
# Date: 3/21/2013
#

class PubCatAggregate
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  MAX_CONTENT_URLS_PER_PUBLISHER = 20
  MAX_CONTENT_URLS_PER_CATEGORY = 20
  
  field :_id, type: Integer
  field :pub_cat_ids_string
  field :pub_cat_aggregate_publishers, type: Array
  field :pub_cat_aggregate_categories, type: Array
  
  index({ pub_cat_ids_string: 1 }, { unique: true, name: "idx_pub_cat_ids_string" })
  
  has_and_belongs_to_many :pub_cat_aggregate_publishers
  has_and_belongs_to_many :pub_cat_aggregate_categories
  
  validates :pub_cat_ids_string, :presence => true
  
  before_save :populate_id, :populate_pub_cat_aggregate_publishers_and_pub_cat_aggregate_categories
  
  
  public
    
    # this function grabs PubCats (and their content_urls) and then aggregate + group them either by publisher 
    # (for 'Filter By Publisher' contents) or by category (for 'Filter By Category' contents)
    
    def populate_pub_cat_aggregate_publishers_and_pub_cat_aggregate_categories
      
      pub_cat_id_array = self.pub_cat_ids_string.split(",").sort!
      pcid_string = pub_cat_id_array.join(",")
      
      # For 'Filter By Publisher', we are iterating all existing Publisher documents, and then checking whether there is a PubCat document
      # related to each of the Publisher document. If there is, add the PubCat's URLs into the PubCatAggregatePublisher doc
      Publisher.all.each do |p|  
        
        pub_cats = PubCat.where(:_id.in => pub_cat_id_array).and(:publisher_id => p._id)
        
        next if pub_cats.count < 1 # skip loop iteration if pub_cat for this p._id doesn't exist
        
        pca_publisher = PubCatAggregatePublisher.where(:pub_cat_ids_string => pcid_string).and(:publisher_id => p._id).first
        
        # It's possible that the PubCatAggregatePublisher item should exist, but has not been created yet; so we create a new one here.  
        unless pca_publisher.present?
          pca_publisher = PubCatAggregatePublisher.new(  :pub_cat_ids_string => pcid_string,
                                                         :publisher_id => p._id,
                                                         :publisher_name => p.name
                                                      )
        end
        
        
        # Since PubCatAggregatePublisher object has a max limit of URLs: MAX_CONTENT_URLS_PER_PUBLISHER, we need to calculate
        # how many content URLs per PubCat we can include, because we want to spread the number of content URLs evenly
        # for each PubCat
        max_content_urls_per_pub_cat = ( MAX_CONTENT_URLS_PER_PUBLISHER / pub_cats.count ).ceil
        
        pca_publisher.content_urls = {}
        
        pub_cats.each do |pc|
          
          c_url_hash = {}
          k = 0
          pc.content_urls.each do |key, val|
            
            c_url_hash[key] = val
            
            k = k + 1
            break if k >= max_content_urls_per_pub_cat
          end
          
          # deep-merge the URLs for this publisher ID: p._id
          pca_publisher.content_urls.deep_merge!(c_url_hash).keys.sort! unless c_url_hash.nil?
          
        end
        
        
        #if pca_publisher.content_urls.present?
          pca_publisher.save
          self.pub_cat_aggregate_publishers << pca_publisher
        #end
      end
      

      # For 'Filter By Publisher', we are iterating all existing Publisher documents, and then checking whether there is a PubCat document
      # related to each of the Publisher document. If there is, add the PubCat's URLs into the PubCatAggregatePublisher doc
      Category.all.each do |c|
        
        pub_cats = PubCat.where(:_id.in => pub_cat_id_array).and(:category_id => c._id)
        
        next if pub_cats.count < 1 # skip loop iteration if pub_cat for this c._id doesn't exist
        
        pca_category = PubCatAggregateCategory.where(:pub_cat_ids_string => pcid_string).and(:category_id => c._id).first
        
        # It's possible that the PubCatAggregateCategory item should exist, but has not been created yet; so we create a new one here.  
        unless pca_category.present?
          pca_category = PubCatAggregateCategory.new(  :pub_cat_ids_string => pcid_string,
                                                       :category_id => c._id,
                                                       :category_name => c.name
                                                    )
        end
        
        # Since PubCatAggregateCategory object has a max limit of URLs: MAX_CONTENT_URLS_PER_PUBLISHER, we need to calculate
        # how many content URLs per PubCat we can include, because we want to spread the number of content URLs evenly
        # for each PubCat
        max_content_urls_per_pub_cat = ( MAX_CONTENT_URLS_PER_CATEGORY / pub_cats.count ).ceil
        
        pca_category.content_urls = {}
        
        pub_cats.each do |pc|
          
          c_url_hash = {}
          j = 0
          pc.content_urls.each do |key, val|
            
            c_url_hash[key] = val
            
            j = j + 1
            break if j >= max_content_urls_per_pub_cat
          end
          
          # deep-merge the URLs for this category ID: c._id
          pca_category.content_urls.deep_merge!(c_url_hash).keys.sort! unless c_url_hash.nil?
          
        end
        
        
        #if pca_category.content_urls.present?
          pca_category.save
          self.pub_cat_aggregate_categories << pca_category
        #end
        
        
      end

    end
    
    
    def self.cron_update_pub_cat_aggregates
      
      PubCat.all.each do |pubcat|
        pubcat.save #Saving will automatically update the content_urls (before_save) 
      end
      
      PubCatAggregate.all.each do |pca|
        pca.save #Saving will automatically update PubCatAggregatePublisher and PubCatAggregateCategory
      end
      
    end
  
end