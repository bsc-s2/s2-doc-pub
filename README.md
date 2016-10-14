# s2-doc-pub

All public doc about S2, including API, demo, FAQ etc.

## Dependency

-   `nodejs`

    ```
    brew install nodejs
    ```

-   `gitbook`

    ```
    npm install gitbook
    ```

-   `ebook-convert`
    install [calibre.app](http://calibre-ebook.com/) first.
    Then

    ```
    sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/bin
    ```

-   `doctoc`
    to generate table-of-content.

    ```
    npm install doctoc
    ```

-   `pandoc`
    to build standalone html from markdown.

    ```
    brew install pandoc
    ```

## Build

`build.sh` generates table-of-content,
compiles markdown to html pages,
generates a all-in-one html page
and update everything it built to branch `release`:

```
./build.sh
```
