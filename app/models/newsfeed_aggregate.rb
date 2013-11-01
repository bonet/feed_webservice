class NewsfeedAggregate
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :newsfeed_ids_string
  field :newsfeed_aggregate_per_publishers, type: Array
  field :newsfeed_aggregate_per_categories, type: Array
  
  index({ newsfeed_ids_string: 1 }, { unique: true, name: "idx_newsfeed_ids_string" })
  
  has_and_belongs_to_many :newsfeed_aggregate_per_publishers
  has_and_belongs_to_many :newsfeed_aggregate_per_categories
  
  validates :newsfeed_ids_string, :presence => true
  
  before_save :populate_id, :populate_newsfeed_aggregate_per_publishers_and_newsfeed_aggregate_per_categories
  
  
  public
  
  def self.cron_update_newsfeed_aggregates
    
    Newsfeed.all.each do |newsfeed|
      newsfeed.save # will automatically update the content_urls (before_save) 
    end
    
    NewsfeedAggregate.all.each do |newsfeed_aggregate|
      newsfeed_aggregate.save # will automatically update NewsfeedAggregatePerPublisher and NewsfeedAggregatePerCategory
    end
    
  end
    
    
    
  private
  
  # this method grabs Newsfeeds and then aggregate them by Publisher and by Category
  def populate_newsfeed_aggregate_per_publishers_and_newsfeed_aggregate_per_categories
    
    self.newsfeed_ids_string = self.newsfeed_ids_string.split(",").uniq.sort!.join(",")
    
    ["publisher", "category"].each do |item|
      
      newsfeed_id_array = self.newsfeed_ids_string.split(",")
      
      
      # Check whether there is a Newsfeed document related to each of the Category / Publisher document.
      # If there is, add the Newsfeed's URLs into the NewsfeedAggregatePerCategory / NewsfeedAggregatePerPublisher doc
      
      Object.const_get(item.capitalize).all.each do |component|
        
        component_id = (item + "_id").to_sym                 # :category_id or :publisher_id
        component_name = (item + "_name").to_sym             # :category_name or :publisher_name
        
        newsfeeds = Newsfeed.where(:_id.in => newsfeed_id_array).and(component_id => component._id)
        
        next if newsfeeds.count < 1
        
        newsfeed_aggregate_per_component_class = Object.const_get("NewsfeedAggregatePer".concat(item.capitalize))
        newsfeed_aggregate_per_component = newsfeed_aggregate_per_component_class.where(:newsfeed_ids_string => self.newsfeed_ids_string).and(component_id => component._id).first

        unless newsfeed_aggregate_per_component.present?
          newsfeed_aggregate_per_component = newsfeed_aggregate_per_component_class.create( :newsfeed_ids_string => self.newsfeed_ids_string,
                                                                                                                  component_id => component._id,
                                                                                                                  component_name => component.name
                                                                                          )
        end
        
        newsfeed_aggregate_per_component_id_sym = ("newsfeed_aggregate_per_" + item + "_ids").to_sym
        self[newsfeed_aggregate_per_component_id_sym] << newsfeed_aggregate_per_component._id
      end
    end
  end
  
end