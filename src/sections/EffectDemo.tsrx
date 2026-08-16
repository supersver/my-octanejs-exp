import { useState, useEffect } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, D, M, G, C, O } from '../lib/highlight.ts';

const OCTANE_CODE = [
  `${K('import')} { useEffect } ${K('from')} ${S("'octane'")};`,
  ``,
  `${K('export function')} ${M('RoomSync')}({ roomId }) {`,
  `  ${C('// No dependency array — compiler infers [roomId]')}`,
  `  useEffect(() => {`,
  `    ${K('const')} socket = connectToRoom(roomId);`,
  `    ${K('return')} () => socket.close();`,
  `  });  ${C('← no [roomId] needed')}`,
  ``,
  `  ${K('return')} ${G('<div')}${G('>')}Connected to {roomId}${G('</div>')};`,
  `}`,
].join('\n');

const REACT_CODE = [
  `${K('import')} { useEffect } ${K('from')} ${S("'react'")};`,
  ``,
  `${K('export function')} ${M('RoomSync')}({ roomId }) {`,
  `  ${C('// React requires explicit dep array')}`,
  `  useEffect(() => {`,
  `    ${K('const')} socket = connectToRoom(roomId);`,
  `    ${K('return')} () => socket.close();`,
  `  }, [roomId]); ${C('← must list every dep manually')}`,
  ``,
  `  ${K('return')} ${G('<div')}${G('>')}Connected to {roomId}${G('</div>')};`,
  `}`,
].join('\n');

const ROOMS = ['general', 'engineering', 'design', 'random'];

export function EffectDemo() @{
  const [room, setRoom] = useState('general');
  const [log, setLog] = useState<string[]>([]);

  // Compiler infers dep on `room` — no array needed
  useEffect(() => {
    const msg = `[effect] connecting to #${room}…`;
    setLog(prev => [msg, ...prev].slice(0, 6));
  });

  <section id="effect-demo" class="py-20 bg-gradient-to-b from-transparent via-violet-500/3 to-transparent">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 4'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'Auto-Inferred Dep Arrays'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{'The compiler reads what your effect uses and builds the dependency list. You write less, and you can never forget a dep.'}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo'}</p>

          <div>
            <p class="text-xs text-[#5a5a72] font-mono mb-2">{'Switch room — watch the effect re-run:'}</p>
            <div class="flex flex-wrap gap-2">
              @for (const r of ROOMS; key r) {
                <button
                  onClick={() => setRoom(r)}
                  class={'px-3 py-1.5 rounded-lg text-xs font-mono border transition-all ' +
                    (room === r
                      ? 'bg-violet-500/15 border-violet-500/35 text-violet-300'
                      : 'border-white/7 text-[#5a5a72] hover:border-white/12 hover:text-white')}
                >
                  {'#' + r as string}
                </button>
              }
            </div>
          </div>

          <div class="bg-[#0d0d14] border border-white/7 rounded-xl p-4 font-mono text-xs flex flex-col gap-1.5 min-h-[160px]">
            <p class="text-[#5a5a72] mb-2">{'// effect log'}</p>
            @for (const entry of log; key entry) {
              <p class="text-emerald-400">{entry as string}</p>
            }
            @empty {
              <p class="text-[#5a5a72]">{'No effects yet'}</p>
            }
          </div>

          <div class="px-4 py-3 bg-[#6c63ff]/8 border border-violet-500/20 rounded-xl">
            <p class="text-xs text-violet-400 font-mono">{'useEffect(() => sync(room)); ← compiler infers dep on room'}</p>
          </div>
        </div>

        <div class="flex flex-col gap-4">
          <CodePanel filename="RoomSync.tsrx — OctaneJS ✓" code={OCTANE_CODE as string} />
          <CodePanel filename="RoomSync.tsx — React (manual deps)" code={REACT_CODE as string} />
        </div>
      </div>
    </div>
  </section>
}
