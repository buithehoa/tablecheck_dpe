# Get All Products

Retrieve a list of all available products in the system.

**URL**: `/api/v1/products`

**Method**: `GET`

**Parameters**:

None required

## Success Response

**Code** : `200 OK`

**Content**:
The response will be a JSON array containing product objects. Each object will have the following properties:
```json
[
  {
    "id": "669b7d31cce3a333a022801d",
    "name": "MC Hammer Pants",
    "price": 3005,
    "adjusted_price": 3005,
    "quantity": 285,
    "category": "Footwear"
  },
  {
    "id": "669b7d31cce3a333a022801e",
    "name": "Thriller Jacket",
    "price": 1511,
    "adjusted_price": 1511,
    "quantity": 241,
    "category": "Accessories"
  }
]
```

## Error Responses

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.
