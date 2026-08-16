import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, D, M, G, O } from '../lib/highlight.ts';

type Status = 'idle' | 'loading' | 'success' | 'error';

const CODE = [
  `${K('export function')} ${M('StatusPanel')}({ status }) ${D('@{')}`,
  `  ${D('@switch')} (status) {`,
  `    ${D('@case')} ${S("'loading'")}: {`,
  `      ${G('<Spinner')} /${G('>')}`,
  `    }`,
  `    ${D('@case')} ${S("'error'")}: {`,
  `      ${G('<p')} class="error"${G('>')}${S('Something went wrong')}${G('</p>')}`,
  `    }`,
  `    ${D('@case')} ${S("'success'")}: {`,
  `      ${G('<p')} class="ok"${G('>')}${S('Data loaded!')}${G('</p>')}`,
  `    }`,
  `    ${D('@default')}: {`,
  `      ${G('<p')} class="idle"${G('>')}${S('Waiting…')}${G('</p>')}`,
  `    }`,
  `  }`,
  `${D('}')}`,
].join('\n');

const STATES: { key: Status; label: string }[] = [
  { key: 'idle',    label: 'Idle'    },
  { key: 'loading', label: 'Loading' },
  { key: 'success', label: 'Success' },
  { key: 'error',   label: 'Error'   },
];

export function ConditionalDemo() @{
  const [status, setStatus] = useState<Status>('idle');

  <section id="conditional-demo" class="py-20 bg-gradient-to-b from-transparent via-violet-500/3 to-transparent">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 2'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'@if · @else · @switch'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{"Rendered control flow stays next to the elements it controls. No ternaries, no &&, no .map() for branches — just natural template blocks."}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-6">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo'}</p>

          {/* State buttons */}
          <div class="flex flex-wrap gap-2">
            @for (const s of STATES; key s.key) {
              <button
                onClick={() => setStatus(s.key)}
                class={'px-4 py-2 rounded-xl text-sm font-mono font-medium border transition-all ' +
                  (status === s.key
                    ? 'bg-[#6c63ff]/20 border-violet-500/40 text-violet-300'
                    : 'border-white/7 text-[#5a5a72] hover:border-white/12 hover:text-white')}
              >
                {s.label as string}
              </button>
            }
          </div>

          {/* Output panel */}
          <div class="flex-1 flex items-center justify-center min-h-[160px] bg-[#0d0d14] border border-white/7 rounded-xl">
            @switch (status) {
              @case 'loading': {
                <div class="flex flex-col items-center gap-3">
                  <div class="w-8 h-8 border-2 border-violet-400 border-t-transparent rounded-full animate-spin"></div>
                  <p class="text-yellow-400 font-mono text-sm">{'Loading…'}</p>
                </div>
              }
              @case 'success': {
                <div class="flex flex-col items-center gap-2">
                  <span class="text-4xl">{'✓'}</span>
                  <p class="text-emerald-400 font-mono text-sm">{'Data loaded successfully!'}</p>
                </div>
              }
              @case 'error': {
                <div class="flex flex-col items-center gap-2">
                  <span class="text-4xl">{'✗'}</span>
                  <p class="text-red-400 font-mono text-sm">{'Something went wrong.'}</p>
                </div>
              }
              @default: {
                <p class="text-[#5a5a72] font-mono text-sm">{'Waiting for action…'}</p>
              }
            }
          </div>

          <p class="font-mono text-xs text-[#5a5a72]">
            {'Active branch: '}
            <span class="text-violet-400">{"@case '" + status + "'"}</span>
          </p>
        </div>

        <CodePanel filename="StatusPanel.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
