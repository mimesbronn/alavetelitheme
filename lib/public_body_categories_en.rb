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

PublicBodyCategories.add(:nb_NO, [
    "Populare myndigheter",
        [ "popular_agency", "Populære instanser", "a lonely agency"],
    "Utøvende makt",
        [ "27", "Departementene", "et departement" ],
        [ "33", "Direktorat og tilsyn", "et direktorat eller tilsyn"],
        [ "38", "Andre sentrale enheter direkte underlagt dep.", "en sentral enhet underlagt departement"],
        [ "39", "Andre regionale og lokale enheter underlagt dep.", "en regional eller lokal enhet underlagt departement"],
        [ "37", "Lokale direktoratsenheter", "en lokal direktoratsenhet"],
        [ "36", "Regionale direktoratsenheter", "en regional direktoratsenhet"],
        [ "76", "Ambassader og utenriksstasjoner", "en ambassade eller utenriksstasjon"],
        [ "68", "Andre statlige instanser", "en statlig instans"],
    "Kommuner",
        [ "66", "Kommunene", "en kommune"],
        [ "73", "Kommunale driftsenheter", "en kommunal driftsenhet"],
    "Dømmende makt",
        [ "19", "Tingrettene og byfogdembetene", "en tingrett eller byfodgembetene"],
])