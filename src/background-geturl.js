console.log('Installing Background');
chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
  console.log('request',request);
  if(request.msg != 'getUrl') return;

  $.get(request.url, request.type || 'text').then(function(response){
    sendResponse(response);
  });
  return true;
});