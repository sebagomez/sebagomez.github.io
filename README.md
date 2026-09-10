# sebagomez.github.io

Source for my personal site: https://sebagomez.github.io

Plain static HTML styled with [Tailwind CSS](https://tailwindcss.com) v4.
No Jekyll, no framework, no runtime JavaScript beyond a small theme toggle.

## Layout

```
index.html          the whole site
404.html            not found page
src/input.css       Tailwind entry point (source)
assets/css/app.css  generated CSS  <- committed, do not edit by hand
assets/img/         images
```

## Development

```bash
npm install
npm run dev     # rebuild assets/css/app.css on every change
npm run serve   # http://localhost:4000
```

## Before you push

`assets/css/app.css` is generated and committed, because GitHub Pages serves
this repo as-is with no build step. Regenerate it after editing any HTML:

```bash
npm run build
```
