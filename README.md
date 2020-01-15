# Xadrez Verbal recommendations crawler

Xadrez Verbal is a Brazilian podcast on international politics. Each episode brings a few cultural recommendations such as movies, books, music etc.

This app is a crawler that goes through Xadrez Verbal's (website)[https://xadrezverbal.com/] for those recommendations, and creates a JSON file with all the recommendations it finds.

## Usage

Give the bin script permission to run:

```bash
  $ sudo chmod +x deploy.sh
```

And run it:

```bash
  $ ./deploy.sh
```

The script will fetch new data, update

## Implementation

`Crawler#call` will first try to load the cache file (in `cache.json`). A cursor is included in the file so we know when the crawler was last run. After fetching the new posts, it will go through them and try to find the recommendations (`compiler/app/fetcher.rb`). The crawler will then save the updated hash into `cache.json` together with the updated cursor.


