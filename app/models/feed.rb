class Feed
  
  include Mongoid::Document

  field :_id, type: Integer
  field :name
  field :description
  field :url
  
=begin
  field :name
  field :url
  
  recursively_embeds_many
  
  
  attr_accessor :parent_id
  attr_accessible :url, :name, :parent_id
  
  
=end

  before_save :populate_id
  
  protected
      
    def populate_id
      logger.debug "....POPULATE_ID: CLASS TYPE IS: " + self.class.to_s
      c = Counter.find( self.class.to_s  )
      if c.nil?
        c = Counter.new # all fields already have default values
        c._id = self.class.to_s
        c.save
      else
        c.inc(:seq, 1) # increment by 1
      end
      
      self._id = c.seq # set the _id
      
      
    end
end
