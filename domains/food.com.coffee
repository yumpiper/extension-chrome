console.log 'food.com'
allIngredients = []
$('.recipe-detail-wrap .ingredient .name').each -> allIngredients.push $(@).text()
console.log allIngredients
matchedIngredients = []
_.each allIngredients, (ingredient)->
  match = ingredient.match ingredientsRegex
  matchedIngredients.push match[1] if match
matchedIngredients = _.uniq matchedIngredients

console.log matchedIngredients

getRatingHtml(matchedIngredients).then (html)->
  $('.recipe-photo-bd.bd').css(position:'relative').append html