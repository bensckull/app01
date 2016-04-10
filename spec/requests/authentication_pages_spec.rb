require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "Page de Connection" do
    before { visit signin_path }

    it { should have_content('Connexion') }
    it { should have_title('Connexion') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Connexion" }

      it { should have_title('Connexion') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Accueil" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
  	
  	describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Mot de Passe", with: user.password
        click_button "Connexion"
      end

      it { should have_title(user.name) }
      it { should have_link('Profil',     href: user_path(user)) }
      it { should have_link('Paramètres',    href: edit_user_path(user)) }
      it { should have_link('Déconexion',    href: signout_path) }
      it { should_not have_link('Connexion', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Déconexion" }
        it { should have_link('Connexion') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Mot de Passe", with: user.password
          click_button "Connexion"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edition Utilisateur')
          end
        end
      end
    end
  
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end