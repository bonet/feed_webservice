#
# Author Class
# Author: Bonet Sugiarto
#
# Description:
# Auto-Incrementing Counter object (a.k.a MongoDB Document Primary Key)
#
# Date: 3/14/2013
#

module IdIncrementer
  
    def populate_id
    
    if self._id.nil?
      
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
end