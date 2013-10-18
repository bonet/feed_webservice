module IdIncrementer
  
    def populate_id
    
    if self._id.nil?
      
      c = Counter.find( self.class.to_s  )
      if c.nil?
        c = Counter.new 
        c._id = self.class.to_s
        c.save
      else
        c.inc(:seq, 1) 
      end
      
      self._id = c.seq 
    
    end
    
  end
end