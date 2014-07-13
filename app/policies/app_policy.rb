 class AppPolicy < ApplicationPolicy

  def index?
    user.present? && (record.user == user)
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.role == "admin")
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    record.class
  end
end

