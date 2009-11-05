# A set of named before filters used to clean up those controllers and make them a little more DRY
#
module Merb  
  module ResponderMixin
    module ClassMethods
      
      # raise NotFound as if action wasn't supported
      #
      def _remove_action_
        raise NotFound
      end
      
      # Removes :edit and :new action
      def no_ui
        before :_remove_action_, :only => [:new, :edit]
      end
      
      def unsupported(opts={})
        before :_remove_action_, opts
      end
      
    end
  end
end