Parse.Cloud.job("bloodhound", function(request, status) {
  var url, submission;

  url = request.params.url;

  submission = {
    "submission":  {
      "title": "",
      "body": "",
      "twitter": "",
      "email": "",
      "songs_attributes": {
        "0": {"url": "froogle.com"},
        "1": {"url": "http://google.com"},
      }
    }
  };



  Parse.Cloud.httpRequest({
    method: 'POST',
    url: 'http://music-news.herokuapp.com/submissions?from=parse',
    body: submission,
    success: function(httpResponse) {
      console.log(httpResponse.text);
    },
    error: function(httpResponse) {
      console.error('Request failed with response code ' + httpResponse.status);
    }
  });
});
