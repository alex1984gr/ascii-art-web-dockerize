# ASCII Art Web — Stylized

## Description

`ascii-art-web` is a web application written in Go that lets you turn any text into ASCII art directly in your browser.

You type some text, pick a banner style, hit **Generate**, and the server returns your text drawn with ASCII characters.

This version (`ascii-art-stylize`) adds a fully styled, responsive, and interactive user interface built with HTML and CSS — no external libraries or frameworks needed.

---

## What it looks like

- Dark green theme with bright green accents
- Works on desktop, tablet, and mobile (responsive design)
- Live character counter while you type
- Highlighted banner selection cards
- Copy-to-clipboard button for the result
- Clear button to reset the form instantly
- Toast notification when you copy the result

---

## Supported banner styles

| Banner      | Description                        |
|-------------|------------------------------------|
| `standard`  | Classic block ASCII letters        |
| `shadow`    | Letters with a shadow effect       |
| `thinkertoy`| Rounded, playful ASCII style       |

---

## Endpoints

| Method | Path        | What it does                                      |
|--------|-------------|---------------------------------------------------|
| GET    | `/`         | Loads the main page with the form                 |
| POST   | `/ascii-art`| Receives the form data and returns the ASCII art  |

### Form fields sent on POST

- `text` — the text you want to convert
- `banner` — the banner style you selected (`standard`, `shadow`, or `thinkertoy`)

---

## HTTP status codes

| Code | Meaning                                                                 |
|------|-------------------------------------------------------------------------|
| 200  | Everything worked, result is shown                                      |
| 400  | Bad request — invalid input, missing fields, or wrong HTTP method       |
| 404  | Not found — wrong URL, missing template file, or missing banner file    |
| 500  | Server error — something unexpected went wrong on the server side       |

---

## Project structure

```
ascii-art-web/
├── main.go                  # Entry point — starts the server
├── web.go                   # HTTP routes, handlers, and error mapping
├── templates/
│   └── index.html           # The web page (HTML + CSS + JS)
├── banners/
│   ├── standard.txt         # Standard banner character map
│   ├── shadow.txt           # Shadow banner character map
│   └── thinkertoy.txt       # Thinkertoy banner character map
├── pipeline/
│   ├── web_render.go        # Entry point for ASCII rendering (RenderASCII)
│   ├── validateInput.go     # Checks that the input text is valid
│   ├── loadBanner.go        # Reads the banner file from disk
│   ├── tokenize.go          # Splits input into renderable tokens
│   ├── renderLines.go       # Converts tokens into ASCII art lines
│   └── ...                  # Other pipeline helpers
└── tests/                   # Unit tests for all pipeline functions
```

---

## How to run

Make sure you have [Go](https://go.dev/) installed, then from the project root run:

```bash
go run .
```

The server starts on:

```
http://localhost:8080
```

Open that URL in your browser and you will see the app.

---

## How to use the app

1. Open `http://localhost:8080` in your browser
2. Type the text you want to convert in the text box
3. Select a banner style (Standard, Shadow, or Thinkertoy)
4. Click **Generate**
5. Your ASCII art appears below the form
6. Click **Copy** to copy it to your clipboard
7. Click **Clear** to reset the form and start over

---

## How to run the tests

Run all tests at once:

```bash
go test ./...
```

Run tests for a specific file or function:

```bash
go test ./tests -run WebRender
```

---

## How the ASCII rendering works (step by step)

1. The user submits the form with `text` and `banner`
2. The handler reads and validates the form fields
3. `pipeline.RenderASCII` is called with the text and banner name
4. The input is validated (no unsupported characters)
5. The banner file is loaded from the `banners/` folder
6. The text is tokenized (split into lines and characters)
7. Each character is looked up in the banner map and drawn line by line
8. The final ASCII art string is returned to the handler
9. The handler passes it to the HTML template which displays it on the page

---

## Technologies used

- **Go** — HTTP server, routing, HTML templating (`html/template`)
- **HTML5** — Page structure and form
- **CSS3** — Styling, responsive layout, animations, and green theme
- **Vanilla JavaScript** — Character counter, clear button, clipboard copy, toast notification

---

## Authors

- agaliand
