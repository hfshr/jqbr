# filters

Each filter is a list with the following required fields.

- `id`: string. unique id for the filter
- `type`: string. Type of the field. Available types are `string`, `integer`, `double`, `date`, `time`, `datetime` and `boolean`.

Other important field that are often useful to include are:

- `label` string. Label used to display the filter.
- `input` string.
  Type of input used. Available types are `text`, `number`, `textarea`, `radio`, `checkbox` and `select`.
  It is also possible to use a javascript function returns the HTML of the said input,
  [see here](/advanced) for an example.
- `values`. vector or named list. Required for `radio` and `checkbox` inputs. Generally needed for `select inputs too.`
- `operators` vector of operators to use for this filter.

A single filter may look something like this:

```r
list(
    id = "category",
    label = "Category",
    type = "string",
    input = "select",
    values = list(
        "Books",
        "Movies",
        "Music",
        "Tools",
        "Goodies",
        "Clothes"
    ),
    description = "I'm a description!",
    operators = c("equal", "not_equal", "in", "not_in", "is_null", "is_not_null")
)
```

There are many more fields that can be included, please see the queryBuilder website for all the options [https://querybuilder.js.org/#filters](https://querybuilder.js.org/#filters)
