# Place Order

Finalize and submit the current order associated with the authenticated user. This action updates product inventory and marks the order as `placed`.

**URL**: `/api/v1/orders/place`

**Method**: `PUT`

**Authentication**:

This endpoint requires a valid API token for authorization. You can obtain your API token from the response of `GET /users` endpoint.

**Parameters**:

`api_token`: (Required) Valid API token for the authenticated user.

## Success Response

**Code** : `200 OK`

**Content**:

The response object indicates successful order placement.
```json
{ "message": "Order placed successfully." }
```

## Error Responses

**Code**: `422 Unprocessable Content`
* Inventory shortage: The quantity of a product in your order exceeds the available inventory.
* No current order: The current user has no active order.
* Order already placed: You cannot place an order that has already been submitted.

**Code**: `401 Unauthorized`

The request is missing a valid API token, or the provided token is invalid.

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.

