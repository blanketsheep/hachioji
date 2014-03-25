#!/bin/sh
cd /vagrant

bundle install
jekyll serve --watch --drafts --future --port 4000