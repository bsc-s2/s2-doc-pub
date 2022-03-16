#!/bin/sh

echo "open localhost:8080/index.html in your browser" >&2
python -m SimpleHTTPServer 8080
