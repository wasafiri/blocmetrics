class AppPolicy < ApplicationPolicy
  #class Scope #not sure you need this here, but let's try running the test again

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    #false
    user.present?
  end

  def new?
    create?
  end

  def update?
    #false
    user.present? && (record.user == user || user.role?(:admin))
  end

  def edit?
    update?
  end

  def destroy?
    #false
    update?
  end

  def scope
    record.class
  end
end

