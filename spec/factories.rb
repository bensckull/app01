FactoryGirl.define do
  factory :user do
    name     				"Michael Hartl"
    email   				"michael@example.com"
    password 				"foobar"
    password_confirmation 	"foobar"
    date_naissance 			"29-04-1994"
    nb_films 				"2"
    m_visio_films 			"Ordinateur"
    nb_livres 				"1"
    livres 					"true"
    PDF_Cv 					""
  end
end