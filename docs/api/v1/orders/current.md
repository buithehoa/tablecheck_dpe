# View Current Order

Retrieve details about the currently active order associated with the authenticated user.

**URL**: `/api/v1/orders/current`

**Method**: `GET`

**Authentication**:

This endpoint requires a valid API token for authorization. You can obtain your API token from the response of `GET /users` endpoint.

**Parameters**:

`api_token`: API token

## Success Response

**Code** : `200 OK`

**Content**:

The response object contains details about the user's current order.
```json
{
  "id": "669d67848c98ade01b2d8518",
  "status": "current",
  "order_items": [
    {
      "product": "Neon Legwarmers",
      "quantity": 2
    }
  ]
}
```

## Error Responses

**Code**: `401 Unauthorized`

The request is missing a valid API token, or the provided token is invalid.

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.

