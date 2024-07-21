# Get Current User (Testing Only)

Retrieve a list of all users in the system. This endpoint is intended for testing purposes only and should not be used in a production environment. It exposes user data which can be a security risk.

**URL**: `/api/v1/users`

**Method**: `GET`

**Authentication**:

This endpoint requires a valid API token for authorization (not implemented for testing purposes only).

**Parameters**:

None required

## Success Response

**Code** : `200 OK`

**Content**:
```json
[
  {
    "id": "669c7f62bcb4458ab96c0df9",
    "username": "larue",
    "api_token": "cITvpT2VKdqsCn8pVIaM3qA8oQ_JLS0N"
  },
  {
    "id": "669c7f62bcb4458ab96c0dfa",
    "username": "thorne",
    "api_token": "hu9YjAycSYrGEzvcsit0XepcXzwlGFQ0"
  }
]
```

## Error Responses

**Code**: `500 Internal Server Error`

An unexpected error occurred on the server while processing the request.
