require 'activerecord'

class Visits < ActiveRecord::Base
end

ActiveRecord.connect(YOURAPP_CONF["db"])
