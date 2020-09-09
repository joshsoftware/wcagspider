# wcagspider

This is a very simple spider that will walk a provided site, finding all of the pages on the site.
It will then either output the page URLs to STDOUT, or call a command on them.

This can be used with another tool like `pa11y` to do additional operations, such as WCAG analysis.

## Usage

The command line processing is extremely simple. If there is one argument, it is the URL of the site.

If there is a second argument, it is the specific command to invoke with the URL of the page to further analyze.

## Pa11y

This is an open source tool for doing WCAG analysis on URLs. Given a working `nodejs` installation, it can be installed with:

```
npm install -g pa11y
```

It does require a working `chromium` installation that is sandbox capable, so it will break on Windows10/WSL1.

By default both `pa11y` and this spider's invocation of it utilize the [HTML CodeSniffer](https://github.com/squizlabs/HTML_CodeSniffer), aka htmlcs, engine to analyze a site.

`pa11y` can also be told to use the `axe-common` tool, via the `--runner axe` command line flag to it. See the `pa11y` documentation for more specific information.

## Todo

- Real command line processing.
- Automatic deduplication of urls -- the spider library should do this, but it seems like sometimes we still get duplicates.
- Eliminate the middleman, and make this tool itself directly use HTMLCS and/or AXE-COMMON without depending on pa11y which in turn depends on them.

## Contributors

- [Kirk Haines](https://github.com/wyhaines) - creator and maintainer
