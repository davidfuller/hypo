module ApplicationHelper

  def my_paginate(items)
    will_paginate items, :renderer => BootstrapLinkRenderer 
  end
end
