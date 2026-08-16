import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, D, M, G, C } from '../lib/highlight.ts';

const CODE = [
  `${K('export function')} ${M('SafePanel')}() ${D('@{')}`,
  `  ${D('@try')} {`,
  `    ${G('<RiskyComponent')} /${G('>')}`,
  `  } ${D('@catch')} (error, reset) {`,
  `    ${G('<div')} class="error-ui"${G('>')}`,
  `      ${G('<p')}${G('>')}`,
  `        {error.message ${K('as')} ${K('string')}}`,
  `      ${G('</p>')}`,
  `      ${G('<button')} onClick={reset}${G('>')}`,
  `        Try again`,
  `      ${G('</button>')}`,
  `    ${G('</div>')}`,
  `  }`,
  `${D('}')}`,
].join('\n');

// Inner component that can intentionally throw
function RiskyInner({ shouldThrow }: { shouldThrow: boolean }) @{
  if (shouldThrow) throw new Error('Simulated crash in RiskyInner');
  <div class="flex flex-col items-center gap-3 py-6">
    <span class="text-4xl">{'⚡'}</span>
    <p class="text-emerald-400 font-mono text-sm">{'Component is running fine!'}</p>
    <p class="text-xs text-[#5a5a72] font-mono">{'Click "Throw error" to simulate a crash'}</p>
  </div>
}

export function TryCatchDemo() @{
  const [shouldThrow, setShouldThrow] = useState(false);
  const [caught, setCaught] = useState<string | null>(null);

  <section id="trycatch-demo" class="py-20 bg-gradient-to-b from-transparent via-violet-500/3 to-transparent">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 6'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'@try / @catch — Error Boundaries'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{"No class components needed. @try/@catch is a template block — error boundaries compose naturally with the same @{} syntax."}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo'}</p>

          {/* Boundary wrapper — manually simulated since @try/@catch is compiler-level */}
          <div class="bg-[#0d0d14] border border-white/7 rounded-xl min-h-[160px] flex items-center justify-center">
            @if (shouldThrow) {
              <div class="flex flex-col items-center gap-3 py-6 text-center px-4">
                <span class="text-4xl">{'💥'}</span>
                <p class="text-red-400 font-mono text-sm">{'Error: Simulated crash in RiskyInner'}</p>
                <p class="text-xs text-[#5a5a72] font-mono">{'@catch (error, reset) — boundary caught it'}</p>
                <button
                  onClick={() => setShouldThrow(false)}
                  class="px-4 py-2 rounded-xl bg-[#6c63ff] hover:bg-violet-500 text-white text-sm font-semibold transition-all"
                >
                  {'Try again (reset)'}
                </button>
              </div>
            } @else {
              <div class="flex flex-col items-center gap-3 py-6">
                <span class="text-4xl">{'⚡'}</span>
                <p class="text-emerald-400 font-mono text-sm">{'Component running fine!'}</p>
                <p class="text-xs text-[#5a5a72] font-mono">{'Click below to simulate a crash'}</p>
              </div>
            }
          </div>

          <button
            onClick={() => setShouldThrow(true)}
            disabled={shouldThrow}
            class={'px-5 py-3 rounded-xl text-sm font-semibold transition-all ' +
              (shouldThrow
                ? 'opacity-40 cursor-not-allowed bg-red-500/20 text-red-400 border border-red-500/20'
                : 'bg-red-500/20 border border-red-500/30 text-red-400 hover:bg-red-500/30')}
          >
            {'Throw error 💥'}
          </button>

          <div class="px-4 py-3 bg-[#6c63ff]/8 border border-violet-500/20 rounded-xl">
            <p class="text-xs text-violet-400 font-mono">{'@try { <RiskyComponent /> } @catch (error, reset) { … }'}</p>
          </div>
        </div>

        <CodePanel filename="SafePanel.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
