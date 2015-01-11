console.log 'daringgourmet.com'
allIngredients = []
$('[itemtype="http://schema.org/Recipe"] [itemprop="ingredients"]').each -> allIngredients.push $(@).text()
console.log allIngredients
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

console.log matchedIngredients

getRatingHtml(matchedIngredients).then (html)->
  $('.pibfi_pinterest:first').css(position:'relative').append html