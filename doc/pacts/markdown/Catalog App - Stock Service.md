### A pact between Catalog App and Stock Service

#### Requests from Catalog App to Stock Service

* [A request for a t-shirt](#a_request_for_a_t-shirt_given_a_t-shirt_exists) given a t-shirt exists

* [A request for a t-shirt](#a_request_for_a_t-shirt_given_there_is_not_a_t-shirt_with_name_surfer-t-shirt) given there is not a t-shirt with name surfer-t-shirt

* [A request for all the t-shirt](#a_request_for_all_the_t-shirt_given_the_t-shirt_stock_is_not_empty) given the t-shirt stock is not empty

* [A request for an t-shirt](#a_request_for_an_t-shirt_given_an_error_occurs_retrieving_a_t-shirt) given an error occurs retrieving a t-shirt

#### Interactions

<a name="a_request_for_a_t-shirt_given_a_t-shirt_exists"></a>
Given **a t-shirt exists**, upon receiving **a request for a t-shirt** from Catalog App, with
```json
{
  "method": "get",
  "path": "/t-shirt/surfer-t-shirt",
  "query": ""
}
```
Stock Service will respond with:
```json
{
  "status": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": {
    "name": "surfer-t-shirt"
  }
}
```
<a name="a_request_for_a_t-shirt_given_there_is_not_a_t-shirt_with_name_surfer-t-shirt"></a>
Given **there is not a t-shirt with name surfer-t-shirt**, upon receiving **a request for a t-shirt** from Catalog App, with
```json
{
  "method": "get",
  "path": "/t-shirt/surfer-t-shirt",
  "headers": {
    "Accept": "application/json"
  }
}
```
Stock Service will respond with:
```json
{
  "status": 404
}
```
<a name="a_request_for_all_the_t-shirt_given_the_t-shirt_stock_is_not_empty"></a>
Given **the t-shirt stock is not empty**, upon receiving **a request for all the t-shirt** from Catalog App, with
```json
{
  "method": "get",
  "path": "/t-shirt",
  "query": ""
}
```
Stock Service will respond with:
```json
{
  "status": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": [
    {
      "name": "surfer-t-shirt"
    },
    {
      "name": "formal-t-shirt"
    }
  ]
}
```
<a name="a_request_for_an_t-shirt_given_an_error_occurs_retrieving_a_t-shirt"></a>
Given **an error occurs retrieving a t-shirt**, upon receiving **a request for an t-shirt** from Catalog App, with
```json
{
  "method": "get",
  "path": "/t-shirt/surfer-t-shirt",
  "headers": {
    "Accept": "application/json"
  }
}
```
Stock Service will respond with:
```json
{
  "status": 500,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": {
    "error": "Argh!!!"
  }
}
```
