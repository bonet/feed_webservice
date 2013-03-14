class Counter
  include Mongoid::Document
  
  field :_id, type: String
  field :seq, type: Integer, default: 1

end