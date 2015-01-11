allIngredients = []
$('.ingredient-wrap .ingredient-name').each -> allIngredients.push $(@).text()
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

getRatingHtml(matchedIngredients).then (html)->
  $('#divHeroPhotoContainer').append html