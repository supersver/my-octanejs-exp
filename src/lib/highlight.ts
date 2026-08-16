// Tiny manual syntax highlighter — no runtime deps, returns an HTML string.
// Colours map to a terminal palette that fits the dark theme.

const escapeHtml = (s: string) =>
  s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;').replaceAll("'", '&#39;');

const token = (color: string) => (s: string) => `<span style="color:${color}">${escapeHtml(s)}</span>`;

const K = token('#c792ea'); // keyword / purple
const T = token('#82aaff'); // type / blue
const S = token('#c3e88d'); // string / green
const N = token('#f78c6c'); // number / orange
const D = token('#6c63ff'); // directive / accent
const C = token('#546e7a'); // comment / grey
const M = token('#ffcb6b'); // identifier / yellow
const G = token('#22d3a5'); // tag / green-teal
const O = token('#a78bfa'); // accent-2 / violet

export { K, T, S, N, D, C, M, G, O };
