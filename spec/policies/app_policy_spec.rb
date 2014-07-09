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

  context "for a confirmed user" do
    let(:user) { FactoryGirl.create(:confirmed_user) }
    let(:app) { FactoryGirl.create(:app) }

    it { should pundit_permit(:show)    }
    it { should pundit_permit(:create)  }
    it { should pundit_permit(:new)     }
  end

  context "for confirmed users" do
    let(:user) { build_stubbed :confirmed_user }

    context "touching other people's stuff" do
      let (:app) { build_stubbed :app, user: build(:user) }

      it { should_not pundit_permit(:update) }
      it { should_not pundit_permit(:edit) }
      it { should_not pundit_permit(:destroy) }
    end

    context "touching their own stuff" do
      let (:app) { build_stubbed :app, user: confirmed_user }

      it { should pundit_permit(:update)  }
      it { should pundit_permit(:edit)    }
      it { should pundit_permit(:destroy) } 
    end
  end

  context "for an admin user" do
    let(:user) { FactoryGirl.create(:admin_user) }
    let(:app) { FactoryGirl.create(:app) }

    it { should pundit_permit(:show)    }
    it { should pundit_permit(:create)  }
    it { should pundit_permit(:new)     }
    it { should pundit_permit(:update)  }
    it { should pundit_permit(:edit)    }
    it { should pundit_permit(:destroy) }
  end
end
