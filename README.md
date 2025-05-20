# best_quotes

A new Flutter project.

## Getting Started

create env file on the lib/ level with all necessary variables

```bash
nano .env
```
when initializing your own realtime database in firebase, an index on category ID shall be made (otherwise, filter won't work)

```json

{
  "rules": {
    ".read": "now < 1750010400000", 
    ".write": "now < 1750010400000",
    "quotes": {".indexOn": "categoryId"}
  }
}
```



### Environment variables

| Variable name   | Description                                                                   | 
|-----------------|-------------------------------------------------------------------------------|
| BASE_QUOTES_URL | base url for realtime database where all quotes are stored. Should end with / |