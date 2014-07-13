require 'spec_helper'

describe AppPolicy do
  subject { AppPolicy.new(user, app) }

  context "for a visitor" do
    let(:user) { nil }
    let(:app) { FactoryGirl.create(:app) }

    it { should     pundit_permit(:show)    }
    it { should_not pundit_permit(:create)  }
    it { should_not pundit_permit(:new)     }
    it { should_not pundit_permit(:update)  }
    it { should_not pundit_permit(:edit)    }
    it { should_not pundit_permit(:destroy) }
  end

  context "for confirmed users" do
    let(:user) { FactoryGirl.build(:user, :confirmed) }

    context "creating a new app" do
      let(:app) { App.new }

      it { should     pundit_permit(:new)     }
      it { should     pundit_permit(:create)  }
    end

    context "touching other people's stuff" do
      let (:app) { build_stubbed :app, user: build(:user) }

      it { should_not pundit_permit(:update)  }
      it { should_not pundit_permit(:edit)    }
      it { should_not pundit_permit(:destroy) }
    end

    context "touching their own stuff" do
      let (:app) { build_stubbed :app, user: user }

      it { should pundit_permit(:update)  }
      it { should pundit_permit(:edit)    }
      it { should pundit_permit(:destroy) } 
    end
  end

  context "for an admin user" do
    let(:user) { FactoryGirl.create(:user, :admin)  }
    let(:app) { FactoryGirl.create(:app)            }

    it { should pundit_permit(:show)                }
    it { should pundit_permit(:create)              }
    it { should pundit_permit(:new)                 }
    it { should pundit_permit(:update)              }
    it { should pundit_permit(:edit)                }
    it { should pundit_permit(:destroy)             }
  end
end
