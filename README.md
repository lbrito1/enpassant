# Xadrez Verbal recommendations crawler

![https://lbrito1.github.io/enpassant/](/content/asset/screenshot.png)

Xadrez Verbal is a Brazilian podcast on international politics. Each episode brings a few cultural recommendations such as movies, books, music etc.

This app goes through Xadrez Verbal's (website)[https://xadrezverbal.com/] looking for those recommendations and compiles them into a friendlier data format, which are then displayed in the website you see in the screenshot above.

## Usage

Give the bin script permission to run:

```bash
  $ sudo chmod +x deploy.sh
```

And run it:

```bash
  $ ./deploy.sh
```

The script will fetch new data, update the JSON cache, update the static web pages and deploy them to Github.io Pages.

## Implementation Notes

### Compiler

`Crawler#call` will first try to load the cache file (in `cache.json`). A cursor is included in the file so we know when the crawler was last run. After fetching the new posts, it will go through them and try to find the recommendations (`compiler/app/fetcher.rb`). The crawler will then save the updated hash into `cache.json` together with the updated cursor.

### Viewer

The viewer uses the excellent [https://github.com/nanoc/nanoc](nanoc) gem to compile static web pages. The pages themselves are very simple, with very few CSS and zero Javascript (except for a Google Analytics tracker).
