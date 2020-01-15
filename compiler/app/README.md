# Xadrez Verbal recommendations crawler

Xadrez Verbal is a Brazilian podcast on international politics. Each episode brings a few cultural recommendations such as movies, books, music etc.

This app is a crawler that goes through Xadrez Verbal's (website)[https://xadrezverbal.com/] for those recommendations, and creates a JSON file with all the recommendations it finds.

## Prerequisites

Must be in the same dir as `xadrez-viewer`.

## Usage

Give the bin script permission to run:

```bash
  $ sudo chmod +x bin/update_site.sh
```

And run it:

```bash
  $ ./bin/update_site.sh
```

The script will fetch new data, update

## Implementation

`Crawler#call` will first try to load the cache file (in `storage/cache.json`). A cursor is included in the file so we know when the crawler was last run. After fetching the new posts, it will go through them and try to find the recommendations (`app/fetcher.rb`). The crawler will then save the updated hash into `cache.json` together with the updated cursor.
# Xadrez compiler


## Crontab

```
0  22 * * 5 /home/leo/work/xadrez-compiler/bin/update_site.sh > /home/leo/work/xadrez-compiler/cronlog
```
