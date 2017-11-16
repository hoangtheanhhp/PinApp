module PinsHelper
    def correct_user? id
        user = Pin.find(id).user
        user===current_user
    end
end
