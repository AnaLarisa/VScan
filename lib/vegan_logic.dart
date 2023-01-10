var nonVeganIngredients = [
  "lapte",
  "unt",
  "brânză",
  "branza",
  "smântână",
  "smantana",
  "frișcă",
  "zer",
  "cazeină",
  "cazeina",
  "ouă",
  "oua",
  "albumină",
  "albumina",
  "ovomucoid",
  "carne",
  "vită",
  "vita",
  "porc",
  "pui",
  "peşte",
  "peste",
  "miere",
  "gelatina",
  "gelatină",
  "şerlac",
  "shellac",
  "carmin",
  "carmină",
  "clei de peşte",
  "extract de cocenila",
  "roșu 4",
  "peptide de colagen",
  "pepsină",
  "pepsina",
  "cheag",
  "e120",
  "e542",
  "e901",
  "e904",
  "e913",
  "e966",
  "e1105",
  "e631",
  "lanolină",
  "lanolina",
  "lactitol",
  "lizozima",
  "maioneza",
  "maioneză",
  "iaurt",
  "acid lactic",
  "lactoză",
  "lactoza",
  "ceară de albine",
  "acid oleic",
  "acid oleinic",
  "untură",
  "untura"
];

var someVeganIngredients = [
  "lapte de soia",
  "lapte de ovaz",
  "lapte de cânepă",
  "lapte de nucă de cocos",
  "lapte de migdale",
  "lapte de mazare",
  "lapte de orez",
  "lapte de alune",
  "lapte de caju",
  "smântână de nuca de cocos",
  "smântână de soia",
  "smântână de ovaz",
  "iaurt de soia",
  "iaurt de cocos",
  "iaurt de caju",
  "brânză de caju",
  "branza de caju",
  "viță de vie",
  "vita de vie"
];

var veganLabels = [
  "plant-based",
  "plant based",
  "vegan",
  "vegetabil",
  "de post",
  "vegana",
  "vegană",
  "vegane"
];

bool isVegan(String ingredient) {
  var suspiciousIngredients = nonVeganIngredients
      .where((e) => ingredient.toLowerCase().contains(e))
      .toList();

  if (suspiciousIngredients.isNotEmpty) {
    var veganLabelsPresent = veganLabels
        .where((element) => ingredient.toLowerCase().contains(element))
        .toList();
    if (veganLabelsPresent.isNotEmpty) {
      return true;
    } else {
      var weStillHaveHope = someVeganIngredients
          .where((element) => ingredient.toLowerCase().contains(element))
          .toList();
      if (weStillHaveHope.isNotEmpty) {
        return true;
      }
    }
    return false;
  } else {
    return true;
  }
}
