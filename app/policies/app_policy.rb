 class AppPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    index?
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

