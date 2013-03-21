#
# Author Class
# Author: Bonet Sugiarto
# Date: 3/14/2013
#

class Counter
  include Mongoid::Document
  
  field :_id, type: String
  field :seq, type: Integer, default: 1

end