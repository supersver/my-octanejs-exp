import { useState, useEffect } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, T, S, D, M, G, O } from '../lib/highlight.ts';

const HERO_CODE = [
  `${K('import')} { useState } ${K('from')} ${S("'octane'")};`,
  ``,
  `${K('export function')} ${M('Counter')}() ${D('@{')}`,
  `  ${K('const')} [count, setCount] = ${T('useState')}(${S('0')});`,
  ``,
  `  ${G('<button')} onClick={() => setCount(c => c + 1)}${G('>')}`,
  `    {${'`'}Clicked ${'{'}count{'}'} times${'`'} ${K('as string')}${O('}')}`,
  `  ${G('</button>')}`,
  `${D('}')}`,
].join('\n');

export function Hero() @{
  const [count, setCount] = useState(0);
  const [renderCount, setRenderCount] = useState(0);

  useEffect(() => {
    setRenderCount(r => r + 1);
  });

  <section class="min-h-screen flex items-center pt-20 pb-16 relative overflow-hidden">
    {/* Grid bg */}
    <div class="pointer-events-none absolute inset-0 bg-[linear-gradient(rgba(108,99,255,0.05)_1px,transparent_1px),linear-gradient(90deg,rgba(108,99,255,0.05)_1px,transparent_1px)] bg-[size:64px_64px]" aria-hidden="true"></div>
    {/* Glow */}
    <div class="pointer-events-none absolute top-0 left-1/2 -translate-x-1/2 w-[900px] h-[500px] bg-[radial-gradient(ellipse,rgba(108,99,255,0.15)_0%,transparent_70%)]" aria-hidden="true"></div>

    <div class="max-w-7xl mx-auto px-5 w-full grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">

      {/* Left */}
      <div>
        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-violet-500/10 border border-violet-500/25 text-violet-400 text-[11px] font-mono mb-6">
          <span class="w-1.5 h-1.5 rounded-full bg-violet-400 animate-pulse"></span>
          {'Alpha · Experiment in progress'}
        </div>

        <h1 class="text-5xl sm:text-6xl lg:text-7xl font-bold tracking-tight leading-none mb-4">
          <span class="text-white">{'Experience'}</span>
          <br/>
          <span class="bg-gradient-to-r from-[#6c63ff] to-violet-400 bg-clip-text text-transparent">{'OctaneJS'}</span>
        </h1>

        <p class="text-lg text-[#9898b2] leading-relaxed mb-8 max-w-lg">
          {'No virtual DOM. No rules of hooks. No dep arrays. Every section below is a live, interactive demo of an OctaneJS feature — running in this very page.'}
        </p>

        {/* Live counter widget */}
        <div class="flex flex-col gap-3 mb-8">
          <div class="flex items-center gap-4 p-5 bg-[#111118] border border-white/7 rounded-2xl">
            <div class="flex-1">
              <p class="text-xs text-[#5a5a72] font-mono mb-1">{'useState — live demo'}</p>
              <p class="text-4xl font-mono font-bold text-violet-300">{(count + '') as string}</p>
              <p class="text-xs text-[#5a5a72] mt-1">{'clicks · ' + renderCount + ' renders total'}</p>
            </div>
            <button
              onClick={() => setCount(c => c + 1)}
              class="px-5 py-3 rounded-xl bg-[#6c63ff] hover:bg-violet-500 text-white text-sm font-semibold transition-all hover:-translate-y-0.5 hover:shadow-lg hover:shadow-violet-500/30"
            >
              {'Click me'}
            </button>
          </div>
          <button onClick={() => setCount(0)}
                  class="text-xs text-[#5a5a72] hover:text-violet-400 font-mono transition-colors self-end">
            {'reset'}
          </button>
        </div>

        <a href="#for-demo"
           class="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-[#6c63ff] hover:bg-violet-500 text-white font-semibold text-sm transition-all hover:-translate-y-0.5 hover:shadow-lg hover:shadow-violet-500/30">
          {'Explore features ↓'}
        </a>
      </div>

      {/* Right — code panel */}
      <div class="flex flex-col gap-3">
        <CodePanel filename="Counter.tsrx" code={HERO_CODE as string} />
        <div class="flex items-center gap-2 px-4 py-2.5 bg-emerald-500/8 border border-emerald-500/20 rounded-xl">
          <span class="text-emerald-400 text-sm">{'✓'}</span>
          <p class="text-xs text-emerald-400 font-mono">{'No dep array in useEffect — compiler infers it automatically'}</p>
        </div>
      </div>

    </div>
  </section>
}
