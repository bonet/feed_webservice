
# MongoDB Document's Primary Key / ID in Integer format.

class Counter
  include Mongoid::Document
  
  field :_id, type: String
  field :seq, type: Integer, default: 1

end