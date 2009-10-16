require File.join(MerbMax.root, 'merb_max', 'core_ext', 'hash_coercion')

module Merb
  module ResponderMixin
    module ClassMethods              
      # Adds a before filter that will coerce param values from HTML forms to useful data :P
      #
      # @param keys [*Splat[Symbol,Hash]] 
      #   Key path to search for in params
      #   Hash will be passed as options to before filter
      # @param block [Proc]
      #   How to coerce the value in the params hash, coercion will happen in place
      #
      #
      # @example
      # 
      def coerce(*keys,&block)
        # Cut out options for before filter
        _opts = keys.last.is_a?(Hash) ? keys.pop : {}
        
        # Create a lambda that will call coerce on the params hash
        _coerce_filter = lambda{ params.coerce(*keys,&block) }
        
        # Do it.
        before(_coerce_filter,_opts)
      end
      
    end
  end
end


