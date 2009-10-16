# usage
# require 'merb_max'
# require 'merb_max/all'
# 
# or just what you want
# require 'merb_max'
# require 'merb_max/coerce'
# 

module MerbMax
  class << self
    def root
      File.dirname(File.expand_path(__FILE__))
    end
  end
end