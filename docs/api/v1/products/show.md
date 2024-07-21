# View Product Details

View product details

**URL**: `/api/v1/products/:id`

**Method**: `GET`

**Parameters**:

`id`: Product ID

## Success Response

**Code** : `200 OK`

**Content**:
```json
{
  "id": "669b7d31cce3a333a022801e",
  "name": "Thriller Jacket",
  "price": 1511,
  "adjusted_price": 1511,
  "quantity": 241,
  "category": "Accessories"
}
```

## Error Responses

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.

**Code**: `404 Not Found`

The provided product ID may not exist in the system.