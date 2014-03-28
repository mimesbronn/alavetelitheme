# encoding: UTF-8
# The PublicBodyCategories structure works like this:
# [
#   "Main category name",
#       [ "tag_to_use_as_category", "Sub category title", "sentence that can describes things in this subcategory" ],
#       [ "another_tag", "Second sub category title", "another descriptive sentence for things in this subcategory"],
#   "Another main category name",
#       [ "another_tag_2", "Another sub category title", "another descriptive sentence"]
# ])

PublicBodyCategories.add(:en, [
    "Silly ministries",
        [ "useless_agency", "Useless ministries", "a useless ministry" ],
        [ "lonely_agency", "Lonely agencies", "a lonely agency"],
    "Popular agencies",
        [ "popular_agency", "Popular agencies", "a lonely agency"]
])

# 12,14,17,18,27,33,38,66,68,76
PublicBodyCategories.add(:nb_NO, [
    "Populare myndigheter",
        [ "popular_agency", "Populære instanser", "en myndighet"],
    "Stortinget",
        [ "12", "Stortinget", "Stortinget" ],
        [ "14", "Stortinget - Etater og ombud", "en etat eller ombud" ],
    "Utøvende makt",
        [ "27", "Departementene", "et departement" ],
        [ "33", "Direktorat og tilsyn", "et direktorat eller tilsyn"],
        [ "38", "Andre sentrale enheter direkte underlagt dep.", "en sentral enhet underlagt departement"],
#        [ "39", "Andre regionale og lokale enheter underlagt dep.", "en regional eller lokal enhet underlagt departement"],
        [ "76", "Ambassader og utenriksstasjoner", "en ambassade eller utenriksstasjon"],
        [ "68", "Andre statlige instanser", "en statlig instans"],
    "Kommuner",
        [ "66", "Kommunene", "en kommune"],
    "Domstolene",
        [ "17", "Høyesterett", "Høyesterett"],
        [ "18", "Lagsmanrettene", "en lagmansrett"],
])
