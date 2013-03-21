#
# PubCatAggregate Class
# Author: Bonet Sugiarto
# Date: 3/21/2013
#

class PubCatAggregate
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  #require 'active_support/core_ext/hash/deep_merge'
  
  field :_id, type: Integer
  field :pub_cat_ids_string
  field :pub_cat_aggregate_publishers, type: Array
  field :pub_cat_aggregate_categories, type: Array
  
  index({ pub_cat_ids_string: 1 }, { unique: true, name: "idx_pub_cat_ids_string" })
  
  has_and_belongs_to_many :pub_cat_aggregate_publishers
  has_and_belongs_to_many :pub_cat_aggregate_categories
  
  #attr_accessible :pub_cat_ids_string
  
  validates :pub_cat_ids_string, :presence => true
  
  before_save :populate_id, :populate_pub_cat_aggregate_publishers_and_pub_cat_aggregate_categories
  
  
  public
  
    def populate_pub_cat_aggregate_publishers_and_pub_cat_aggregate_categories
      
      pub_cat_id_array = self.pub_cat_ids_string.split(",").sort!
      pcid_string = pub_cat_id_array.join(",")
      
      # populate PubCatAggregatePublishers
      Publisher.all.each do |p|
        
        pca_publisher = PubCatAggregatePublisher.where(:pub_cat_ids_string => pcid_string).and(:publisher_id => p._id).first
        
        unless pca_publisher.present?
          pca_publisher = PubCatAggregatePublisher.new(  :pub_cat_ids_string => pcid_string,
                                                         :publisher_id => p._id,
                                                         :publisher_name => p.name
                                                      )
        end
        #logger.debug "\n\n ==============>>>>>> :pub_cat_ids_string: " + pcid_string + " || :publisher_id: " +  p._id.to_s
        #logger.debug " ..... pca_publisher: " + pca_publisher.inspect.to_s
        pca_publisher.content_urls = {}
        
        PubCat.where(:_id.in => pub_cat_id_array).and(:publisher_id => p._id).each do |pubcat|
          
          pca_publisher.content_urls.deep_merge!(pubcat.content_urls)
        end
        
        if pca_publisher.content_urls.present?
          pca_publisher.save
          self.pub_cat_aggregate_publishers << pca_publisher
        end
      end
      

      # populate PubCatAggregateCategories
      Category.all.each do |p|
        
        pca_category = PubCatAggregateCategory.where(:pub_cat_ids_string => pcid_string).and(:category_id => p._id).first
        
        unless pca_category.present?
          pca_category = PubCatAggregateCategory.new(  :pub_cat_ids_string => pcid_string,
                                                       :category_id => p._id,
                                                       :category_name => p.name
                                                    )
        end
        
        pca_category.content_urls = {}
        
        PubCat.where(:_id.in => pub_cat_id_array).and(:category_id => p._id).each do |pubcat|
          
          pca_category.content_urls.deep_merge!(pubcat.content_urls)
        end
        
        if pca_category.content_urls.present?
          pca_category.save
          self.pub_cat_aggregate_categories << pca_category
        end
        
        
      end

    end
  
end