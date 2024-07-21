# Import Products

Import products from a CSV file following the format specified below. A sample CSV file is available [here](https://github.com/TableCheck-Labs/tablecheck-ruby-take-home/blob/main/inventory.csv).

**URL**: `/api/v1/products/import`

**Method**: `POST`

**Headers**: `Content-Type: multipart/form-data`

**Parameters**:

`inventory`: (Required) Path to the CSV file containing product data.

**Request Body**:
The CSV file must adhere to the following format:

```csv
NAME,CATEGORY,DEFAULT_PRICE,QTY
MC Hammer Pants,Footwear,3005,285
Thriller Jacket,Accessories,1511,241
Cabbage Patch Hat,Clothing,1800,254
Neon Legwarmers,Footwear,876,198
```

## Success Response

**Code** : `200 OK`

**Content**:
```json
{ message: "Inventory imported successfully."}
```

## Error Responses

**Condition**: Non-CSV file was selected or CSV file is malformed.

**Code**: `422 Unprocessable Content`

**Content**:
```json
{ message: "Please select a CSV file to import."}
```
