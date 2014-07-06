class AppPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
    user.present?
  end

  def new?
    create?
  end

  def update?
    false
    user.present? && (record.user == user || user.role?(:admin))
  end

  def edit?
    update?
  end

  def destroy?
    false
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

