require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "page de profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

    describe "page d'inscription" do
    before { visit signup_path }

    it { should have_content('Inscription') }
    it { should have_title(full_title('Inscription')) }
  end

  describe "inscription" do

    before { visit signup_path }

    let(:submit) { "Création du compte" }

    describe "avec des information éronés" do
      it "ne doit pas créer d'utilisateur" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "avec des information valides" do
      before do
        fill_in "Nom",                                            with: "Example User"
        fill_in "Email",                                          with: "user@example.com"
        fill_in "Mot de Passe",                                   with: "foobar"
        fill_in "Confirmation",                                   with: "foobar"
        fill_in "Nombre de films moyen vus par semaine :",        with: "2"
        fill_in "Nombre de livres moyen Lu par semaine :",        with: "1"
      end

      it "devrait créer un utilisateur" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "apres la sauvegarde de l'utilisateur" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Déconexion') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenue') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Modification du profile") }
      it { should have_title("Edition Utilisateur") }
      it { should have_link('changer', href: 'http://gravatar.com/emails') }
    end

    describe "avec des informations éronés" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nom",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Mot de Passe",         with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Sauver"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Déconexion', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end