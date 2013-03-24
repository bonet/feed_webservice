#
# PubCatNamelist Class
#
# Description:
# PubCatNamelist is a list of all Publishers (1st level) and Categories for each Publisher (2nd Level), so it's filter by Publisher.
# This is used e.g. during signup where the user needs to see all available Feed Publishers and Categories.
#
# Author: Bonet Sugiarto
# Date: 3/21/2013
#

class PubCatNamelist
  
  include Mongoid::Document
  
  field :namelist
end