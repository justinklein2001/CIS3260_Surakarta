# Author: Justin Klein
# Date: 2023-11-05
# Class Name: UserIntefaceValidator.rb
class UserInterfaceValidator
    
    # Validates if the provided input can be parsed as a coordinate
    def input_is_coordinate(input)
        
        x, y = input.split(',')
        
        if (x.match?(/\A-?\d+\z/) && x.match?(/\A-?\d+\z/))
            return true
        end

        return false
    end
end