#
# Author Class
# Author: Bonet Sugiarto
#
# Description:
# MongoDB Document's Primary Key / ID in Integer format.
#
# Date: 3/14/2013
#

class Counter
  include Mongoid::Document
  
  field :_id, type: String
  field :seq, type: Integer, default: 1

end