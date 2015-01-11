$('#b_context, .b_ad').remove()
console.log 'Yo FOOOOOD'
console.log $('#main')

loadBingResult = (element)->
  console.log recipeUrl = $(element).find('h2 > a[href]').first().attr('href')
  $.get(recipeUrl, 'text').then (results)->
    myParsedElement = $(results)

    allIngredients = []
    myParsedElement.find('[itemprop="ingredients"]').each -> allIngredients.push $(@).text()
    matchedIngredients = []
    _.each allIngredients, (ingredient)->
      match = ingredient.match ingredientsRegex
      matchedIngredients.push match[1] if match
    matchedIngredients = _.uniq matchedIngredients
    console.log recipeUrl, matchedIngredients
    if not matchedIngredients.length
      $(element).find('h2').addClass('done')
      return
    getRating(matchedIngredients)
    .done ->
      $(element).find('h2').addClass('done');
    .then (result)->
      console.log result:result
      return unless result.ratings.yummy + result.ratings.health >0
      console.log result
      $(element).find('h2').append "
      <span class='HACKATHON-search-wrapper'>
        <span class='HACKATHON-google yummie'>Yummie #{result.ratings.yummy}</span>
        <span class='HACKATHON-google healthy'>Healthy #{result.ratings.health}</span>
      </span>"
$('#b_results .b_algo').each -> loadBingResult @
