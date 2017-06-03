module WikiHelper
    def user_is_authorized_for_wikis?(wiki)
        current_user && (current_user == wiki.user || current_user.admin?)
    end
end

