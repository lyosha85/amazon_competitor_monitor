module Service
  extend ActiveSupport::Concern

  module ClassMethods
    # A class method that passes all the arguments given to it to the {#call}
    # instance method of a newly created instance of the class that this module
    # is included into.
    def call(*args)
      if block_given?
        new(*args).call do
          yield
        end
      else
        new(*args).call
      end
    end
  end
end
