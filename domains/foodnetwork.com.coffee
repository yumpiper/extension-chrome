console.log 'foodnetwork.com'
allIngredients = []
$('.ingredients-instructions li[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
console.log allIngredients
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

console.log matchedIngredients

getRatingHtml(matchedIngredients).then (html)->
  $('.photo-video > figure').css(position:'relative').append html