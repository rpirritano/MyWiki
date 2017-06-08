class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    #scope.where(id: record.id).exists?
    !record.private? || (user.present? && (user.admin? || record.user == user || record.users.include?(user)))
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
     (user.admin? || (record.user == user)) if user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.try(:admin?)
        wikis = scope.all # If the user is an admin, scope all the wikis
      elsif user.try(:premium?)
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # If the user is premium, scope all public wikis and wikis that have created, and private wikis they are collaborators on
          end
        end

      elsif user.try(:standard?)
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.users.include?(user)
            wikis << wiki # If the user is a standard user, scope in all public wikis and private wikis they are collaborators on
          end
        end
       else
        wikis = scope.where(private: false)
      end
      wikis
    end
  end
end