module Ipset
  # Helper functions available in all set templates.
  module TemplateHelpers
    # Turn an options hash into a string of options
    # for ipset.  Boolean options don't take arguments.
    def options_to_s(hash)
      return hash.to_s unless hash.is_a?(Hash)

      options = []

      hash.each_pair do |k, v|
        if v.is_a?(FalseClass)
          next
        elsif v.is_a?(TrueClass)
          options << k.to_s
        else
          options << "#{k} \"#{v}\""
        end
      end

      options.join(' ')
    end
  end
end
