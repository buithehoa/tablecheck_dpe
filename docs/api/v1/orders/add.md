# Add Product to Order

Add a product to the current order of the current authenticated user.

**URL**: `/api/v1/orders/add`

**Method**: `PUT`

**Authentication**:

This endpoint requires a valid API token for authorization. You can obtain your API token from the response of `GET /users` endpoint.

**Parameters**:

`api_token`: API token

`product_id`: Product ID

## Success Response

**Code** : `200 OK`

**Content**:

The response object will contain details about the updated current order, including the newly added product.
```json
{
  "id": "669d67848c98ade01b2d8518",
  "status": "current",
  "order_items": [
    {
      "product": "Neon Legwarmers",
      "quantity": 2
    },
    {
      "product": "Rambo Bandana",
      "quantity": 5
    }
  ]
}
```

## Error Responses

**Code**: `401 Unauthorized`

The request is missing a valid API token, or the provided token is invalid.

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.

