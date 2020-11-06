module ApplicationHelper
    def is_event_admin?(admin)
        current_user.id == admin.id
    end

    def is_current_user_guest?(event)
        Attendance.where(user_id: current_user.id, event_id: event.id).size > 0
    end

    def get_admin(event)
        User.find(event.admin_id)
    end

    def attended_on?(guest, event)
        Attendance.where(user_id: guest.id, event_id: event.id).first.created_at
    end

    def guest_already_participated(array_of_guest)
        result = 0 
        array_of_guest.each do |guest|
            if guest.id == current_user.id
                result = 1
            end
        end
        if result == 1
            return true
        else 
            return false
        end
    end
end
