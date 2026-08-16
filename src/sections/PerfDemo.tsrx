import { useState, useEffect, useRef } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, T, S, M, G, C, O, N } from '../lib/highlight.ts';

const CODE = [
  `${C('// No virtual DOM — direct node writes')}`,
  `${C('// Compiled output (simplified):')}`,
  ``,
  `${K('const')} _t = /* @__PURE__ */ _$template(`,
  `  ${S('"<div class=\\"cell\\"></div>"')}`,
  `);`,
  ``,
  `${K('function')} ${M('renderCell')}(color) {`,
  `  ${K('const')} el = _t.cloneNode();`,
  `  ${C('// Direct style write — no vDOM diff')}`,
  `  el.style.background = color;`,
  `  ${K('return')} el;`,
  `}`,
  ``,
  `${C('// React equivalent: reconciles entire vDOM tree,')}`,
  `${C('// then patches matching DOM nodes.')}`,
  `${C('// ~6 KB runtime (Octane) vs ~45 KB (React)')}`,
].join('\n');

// The source used by the live Feature 8 example, including its Octane directives
// and Tailwind utility classes.
const ACTUAL_CODE = [
  `${K('import')} { useState, useEffect, useRef } ${K('from')} ${S("'octane'")};`,
  ``,
  `${K('const')} GRID_SIZE = ${N('100')};`,
  `${K('const')} CELL_INDEXES = Array.from({ length: GRID_SIZE }, (_, index) => index);`,
  ``,
  `${K('function')} ${M('randomColor')}() {`,
  `  ${K('const')} hues = [${N('260')}, ${N('280')}, ${N('220')}, ${N('200')}, ${N('170')}];`,
  `  ${K('const')} h = hues[Math.floor(Math.random() * hues.length)];`,
  `  ${K('const')} l = ${N('40')} + Math.floor(Math.random() * ${N('25')});`,
  `  ${K('return')} \`hsl(\${h}, 70%, \${l}%)\`;`,
  `}`,
  ``,
  `${K('export function')} ${M('PerfDemo')}() ${O('@{')}`,
  `  ${K('const')} gridRef = useRef${T('<HTMLDivElement | null>')}(${K('null')});`,
  `  ${K('const')} [updateCount, setUpdateCount] = useState(${N('0')});`,
  `  ${K('const')} [running, setRunning] = useState(${K('false')});`,
  `  ${K('const')} [fps, setFps] = useState(${N('0')});`,
  ``,
  `  useEffect(() => {`,
  `    ${K('const')} grid = gridRef.current;`,
  `    ${K('if')} (!running || !grid) ${K('return')};`,
  `    ${K('let')} frame = ${N('0')};`,
  `    ${K('let')} updates = ${N('0')};`,
  `    ${K('let')} lastTime = performance.now();`,
  `    ${K('let')} rafId: ${T('number')};`,
  ``,
  `    ${K('const')} tick = () => {`,
  `      ${K('const')} now = performance.now();`,
  `      frame++;`,
  `      updates++;`,
  ``,
  `      ${K('for')} (${K('const')} cell ${K('of')} grid.children) {`,
  `        (cell ${K('as')} ${T('HTMLElement')}).style.backgroundColor = randomColor();`,
  `      }`,
  `      ${K('if')} (now - lastTime >= ${N('500')}) {`,
  `        setFps(Math.round((frame / (now - lastTime)) * ${N('1000')}));`,
  `        setUpdateCount(updates);`,
  `        frame = ${N('0')}; lastTime = now;`,
  `      }`,
  `      rafId = requestAnimationFrame(tick);`,
  `    };`,
  `    rafId = requestAnimationFrame(tick);`,
  `    ${K('return')} () => cancelAnimationFrame(rafId);`,
  `  });`,
  ``,
  `  ${G('<div')} ref={gridRef} class="grid w-full gap-1" style="grid-template-columns: repeat(10, minmax(0, 1fr))"${G('>')}`,
  `    ${O('@for')} (${K('const')} index ${K('of')} CELL_INDEXES; ${K('key')} index) {`,
  `      ${G('<div')} class="aspect-square min-w-0 rounded-sm bg-[#1a1a2e] transition-none"${G('></div>')}`,
  `    }`,
  `  ${G('</div>')}`,
  `${O('}')}`,
].join('\n');

const GRID_SIZE = 100;
const CELL_INDEXES = Array.from({ length: GRID_SIZE }, (_, index) => index);

function randomColor() {
  const hues = [260, 280, 220, 200, 170];
  const h = hues[Math.floor(Math.random() * hues.length)];
  const l = 40 + Math.floor(Math.random() * 25);
  return `hsl(${h}, 70%, ${l}%)`;
}

export function PerfDemo() @{
  const gridRef = useRef<HTMLDivElement | null>(null);
  const [updateCount, setUpdateCount] = useState(0);
  const [running, setRunning] = useState(false);
  const [fps, setFps] = useState(0);

  useEffect(() => {
    const grid = gridRef.current;
    if (!running || !grid) return;
    let frame = 0;
    let updates = 0;
    let lastTime = performance.now();
    let rafId: number;

    const tick = () => {
      const now = performance.now();
      frame++;
      updates++;

      for (const cell of grid.children) {
        (cell as HTMLElement).style.backgroundColor = randomColor();
      }

      if (now - lastTime >= 500) {
        setFps(Math.round((frame / (now - lastTime)) * 1000));
        setUpdateCount(updates);
        frame = 0;
        lastTime = now;
      }
      rafId = requestAnimationFrame(tick);
    };
    rafId = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(rafId);
  });

  const toggleAnimation = () => {
    if (!running) {
      setUpdateCount(0);
      setFps(0);
    }
    setRunning(value => !value);
  };

  const resetGrid = () => {
    setUpdateCount(0);
    setFps(0);
    const grid = gridRef.current;
    if (!grid) return;
    for (const cell of grid.children) {
      (cell as HTMLElement).style.backgroundColor = '#1a1a2e';
    }
  };

  <section id="perf-demo" class="py-20 bg-gradient-to-b from-transparent via-violet-500/3 to-transparent">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 8'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'Direct DOM · No vDOM'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{'OctaneJS compiles templates to cloned DOM nodes with direct writes. No virtual DOM reconciliation, no diffing pass.'}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <div class="flex items-center justify-between">
            <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'100-cell grid · direct DOM writes'}</p>
            <div class="flex items-center gap-4 font-mono text-xs">
              <span class="text-violet-400">{(updateCount + ' updates') as string}</span>
              @if (running) {
                <span class="text-emerald-400">{(fps + ' fps') as string}</span>
              }
            </div>
          </div>

          {/* Grid */}
          <div ref={gridRef} class="grid w-full gap-1" style="grid-template-columns: repeat(10, minmax(0, 1fr))">
            @for (const index of CELL_INDEXES; key index) {
              <div class="aspect-square min-w-0 rounded-sm bg-[#1a1a2e] transition-none"></div>
            }
          </div>

          <div class="flex gap-3">
            <button
              onClick={toggleAnimation}
              class={'flex-1 py-3 rounded-xl text-sm font-semibold transition-all ' +
                (running
                  ? 'bg-red-500/20 border border-red-500/30 text-red-400 hover:bg-red-500/30'
                  : 'bg-[#6c63ff] hover:bg-violet-500 text-white hover:-translate-y-0.5')}
            >
              {running ? 'Stop' : 'Start animation' as string}
            </button>
            <button
              onClick={resetGrid}
              class="px-4 py-3 rounded-xl text-xs font-mono text-[#5a5a72] border border-white/7 hover:border-white/12 hover:text-white transition-all"
            >
              {'Reset'}
            </button>
          </div>

          {/* Stats */}
          <div class="grid grid-cols-2 gap-3">
            <div class="px-4 py-3 bg-[#0d0d14] border border-white/7 rounded-xl text-center">
              <p class="font-mono text-lg font-bold text-violet-400">{'~6 KB'}</p>
              <p class="text-xs text-[#5a5a72]">{'OctaneJS runtime (gzip)'}</p>
            </div>
            <div class="px-4 py-3 bg-[#0d0d14] border border-white/7 rounded-xl text-center">
              <p class="font-mono text-lg font-bold text-[#5a5a72]">{'~45 KB'}</p>
              <p class="text-xs text-[#5a5a72]">{'React runtime (gzip)'}</p>
            </div>
          </div>
        </div>

        <CodePanel filename="PerfDemo.tsrx" code={ACTUAL_CODE as string} />
      </div>
    </div>
  </section>
}
