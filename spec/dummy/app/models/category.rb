class Category < ActiveRecord::Base
  #
  has_ancestry :cache_depth=>true
  # it uses column ancestry_depth


end
