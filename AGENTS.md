# AGENTS.md

Context for AI agents working on this repository.

## What this is

The personal site of Sebastián Gómez, served by GitHub Pages at
https://sebagomez.github.io from the `master` branch.

It is **plain static HTML styled with Tailwind CSS v4**. There is no Jekyll,
no framework, no templating, and no runtime JavaScript beyond a theme toggle
and a small photo carousel. One page. Keep it that way unless asked.

The repo used to be built from the Jalpc Jekyll theme. That was removed in the
"Rebuild site with Tailwind CSS" commit. If you find references to Jalpc,
Bootstrap, jQuery, i18next or a `static/` directory, they are stale.

## Layout

```
index.html            the entire site
404.html              not-found page, shares the theme
src/input.css         Tailwind entry point (SOURCE - edit this)
assets/css/app.css    generated CSS (DO NOT EDIT - run the build)
assets/img/           avatar and project icons
assets/img/photos/    carousel photos
package.json          build scripts
.github/workflows/css.yml   CI check that the committed CSS is current
```

## Build

`npm` may not be on PATH in this environment. If `npm -v` fails with
"could not find real npm binary", prefix commands with:

```bash
export PATH=/nix/store/m3wj2l4bir43rj1swgjic7k6w8ppjm97-nodejs-24.15.0/bin:$PATH
```

Then:

```bash
npm run build   # regenerate assets/css/app.css (minified)
npm run dev     # same, in watch mode
npm run serve   # python3 -m http.server 4000
```

**After editing any HTML, run `npm run build` and commit the result.**
`assets/css/app.css` is a generated file that is committed on purpose, because
GitHub Pages serves this repo as-is with no build step. CI regenerates it and
fails the PR if the committed copy is stale.

Preview with a real HTTP server, not `file://`. All asset paths are absolute
(`/assets/...`), so opening the file directly loads no CSS.

## Conventions

- **Tailwind utility classes only.** No custom CSS in the HTML, no `<style>`
  blocks. If a utility does not exist, add an `@utility` to `src/input.css`
  (v4 syntax; there is no `tailwind.config.js`).
- **Scanned files are pinned.** `src/input.css` starts with
  `@import "tailwindcss" source(none)` followed by explicit `@source` lines for
  `index.html` and `404.html`. If you add a new page, add an `@source` line for
  it or it will render unstyled.
- **Dark mode is class-based.** `src/input.css` declares
  `@custom-variant dark (&:where(.dark, .dark *))`, so `dark:` compiles against
  a `.dark` class on `<html>`, not `prefers-color-scheme`. An inline script in
  `<head>` sets that class before first paint, reading `localStorage.theme` and
  falling back to the OS setting. Do not move that script to the end of the
  body; it would cause a white flash for dark-mode visitors.
- **Every colour needs a dark counterpart.** Adding `bg-white text-slate-700`
  means also adding `dark:bg-slate-950 dark:text-slate-300`. Palette in use:
  slate for surfaces and text, sky for accents.
- **Content width** is `mx-auto max-w-3xl px-5`. Full-bleed elements (the
  carousel) sit outside `<main>`.
- **Images** need `width` and `height` attributes to avoid layout shift, and
  `loading="lazy"` unless above the fold.
- **External links** use `target="_blank" rel="noopener"`. Social profile links
  also carry `rel="me"`.
- Formatting is Prettier-style: 2 spaces, double quotes in HTML attributes.
  The Google Analytics snippet is deliberately left exactly as Google emits it,
  single quotes and all, so future updates are a clean paste-over.

## Things that will bite you

- **Do not run a headless browser (jsdom, Puppeteer) against `index.html` in a
  blocking shell.** The carousel calls `setInterval`, which keeps the Node
  event loop alive forever and hangs the process. Use a timeout and an explicit
  `process.exit(0)`.
- **`timeout` is not installed** on this machine (no GNU coreutils).
- **Hard-reload when testing** (`Cmd+Shift+R`). A cached `app.css` after a
  rebuild makes the page look broken in confusing ways.
- **Carousel pause logic must always be reversible.** Every pause needs a
  matching resume. Touch devices never fire `pointerleave`, so hover-pause is
  filtered to `e.pointerType === "mouse"`, and taps use a pause-then-resume
  timer. A one-way pause silently kills autoplay.
- **Analytics is live.** GA4 measurement ID `G-T66SRS9W9E`, in both
  `index.html` and `404.html`. The 404 page overrides `page_path` to record
  which URL was missing. Localhost traffic is counted on purpose; the owner
  prefers keeping Google's snippet unmodified over filtering it.
- **Never let Tailwind scan prose.** By default Tailwind v4 scans every file in
  the project for anything that looks like a class name. Words in Markdown
  count: "an inline script in `<head>`" in this very file made the build emit
  `.inline{display:inline}`, which broke the CI staleness check. That is why
  scanning is pinned to the two HTML pages. Do not remove `source(none)`.
- **Merging to `master` publishes immediately.** There is no staging site.

## Content facts

- Sebastián Gómez, Senior Engineer, UCP Platform at Shopify (since Aug 2026).
- Lives in Montreal, Canada. From Uruguay. English is his second language.
- Tagline: "World's okayest software engineer."
- Career runs from ST Consultores (1999) to Shopify, 8 entries.
- Projects: Azure Storage Explorer, dotnet-operator-sdk, shelltwit, VSProlog.
- Blog lives at https://dev.to/sebagomez, not on this site.
- Socials: GitHub, LinkedIn, X/Twitter, Bluesky, Instagram, DEV. Mastodon was
  removed on purpose - do not add more without asking.
- Carousel photos are of Punta del Este, Uruguay, shot by @Picardo2009
  (https://picardo.photography/). The credit in the footer must stay.

## Working with the owner

- Explain the plan before changing code, and wait for approval.
- Plain, simple English. Short sentences.
- He is a senior engineer with deep DevOps and CI/CD experience. Do not
  over-explain architecture. Do explain JavaScript, CSS and Tailwind specifics,
  which are not his daily languages (C#, Python, Bash are).
- Do not commit, push, or open PRs unless asked.
- This is a personal GitHub repo, so use `gh` for pull requests.
- One commit per PR. Amend and force-push with `--force-with-lease` rather than
  stacking review-fix commits.
- Never merge unless explicitly asked.
