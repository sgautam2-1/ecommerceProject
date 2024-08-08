class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

# Since ApplicationRecord is an abstract class and typically does not contain attributes, there are no validations needed directly in this class.
