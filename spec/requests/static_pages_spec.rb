require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "page d'Accueil" do
    before { visit root_path }

    it { should have_content('Web App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Accueil') }
  end

  describe "page d'aide" do
    before { visit help_path }

    it { should have_content('Aide') }
    it { should have_title(full_title('Aide')) }
  end

  describe "page A propos" do
    before { visit about_path }

    it { should have_content('propos') }
    it { should have_title(full_title('A_propos')) }
  end

  describe "page de Contact" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end