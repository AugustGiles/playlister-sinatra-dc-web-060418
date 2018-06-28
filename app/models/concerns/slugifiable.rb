module Slugifiable


  module InstanceMethods
    def slug
      self.name.gsub(/[^0-9A-Za-z]/, "-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(x)
      self.all.find {|instance| instance.slug == x}
    end
  end

end
