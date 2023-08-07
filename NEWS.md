# jqbr 1.0.3

- Package has been renamed from `qbr` -> `jqbr` to avoid a conflict with an existing CRAN package called `qbr` [#7](https://github.com/hfshr/jqbr/issues/7)

# qbr 1.0.2

- Fixed issue where `is_na` and `is_not_na` operators were not being displayed [#4](https://github.com/hfshr/jqbr/issues/4)

# qbr 1.0.1

- Remove base R pipe operators from `run_qbr_demo()`.

# qbr 1.0.0

**Breaking changes**

- This is a complete rewrite of an earlier version of `qbr` which used the `htmlwidgets` framework. `qbr` now provides shiny input bindings and adds several new features. The `htmlwidgets` version can still be installed from the the old_widget branch on github.

For more details on version 1.0.0, check out the documentation [here](https://hfshr.github.io/jqbr/#/basic-usage),

**New features**

- `useQueryBuilder()` has a `bs_version` argument that can be used to ensure the builder is compatible with the version of bootstrap used.
- `updateQueryBuilder()` enables several method to update an existing querybuilder input, including adding new filters, reseting the builder and setting rules to the builder
- `queryBuilder()` gains a `return_value` argument to control the return vaue from the builder.
- See a demo application by running `run_qbr_demo()`.
- Improved documentation at [https://hfshr.github.io/jqbr/](https://hfshr.github.io/jqbr/)

# qbr 0.0.1

- Added a `NEWS.md` file to track changes to the package.
