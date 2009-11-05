# A set of named before filters used to clean up those controllers and make them a little more DRY
#
module Merb  
  module ResponderMixin

    # The 'guts' of removing an action
    #
    # raise NotFound as if action wasn't supported
    #
    def _remove_action_
      raise ::Merb::ControllerExceptions::NotFound
    end

    module ClassMethods
      # Removes a list of actions
      #
      def remove_action(*_acts)
        before :_remove_action_, :only => _acts
      end

      # Removes :edit and :new action
      def no_ui
        remove_action :new, :edit
      end
      
      # Takes options as a normal before filter
      #
      # Sets actions as unsupported
      #
      # @example
      #   unsupported :only => [:things, :that, :are, :unsupported]
      #   unsupported :exclude => [:things, that, :are, :supported]
      def unsupported(opts={})
        before :_remove_action_, opts
      end
      
    end
  end
end