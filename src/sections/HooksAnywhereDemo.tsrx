import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, D, M, G, C } from '../lib/highlight.ts';

const OCTANE_CODE = [
  `${C('// ✓ OctaneJS — hooks tracked by location, not order')}`,
  `${K('export function')} ${M('Profile')}(props) {`,
  `  ${K('if')} (!props.user) ${K('return')} ${G('<EmptyState')} /${G('>')};`,
  ``,
  `  ${C('// Hook AFTER an early return — totally fine in Octane')}`,
  `  ${K('const')} [editing, setEditing] = useState(${K('false')});`,
  ``,
  `  ${K('return')} (`,
  `    ${G('<button')} onClick={() => setEditing(!editing)}${G('>')}`,
  `      {editing ? ${S("'Cancel'")} : ${S("'Edit profile'")} ${K('as')} ${K('string')}}`,
  `    ${G('</button>')}`,
  `  );`,
  `}`,
].join('\n');

const REACT_CODE = [
  `${C('// ✗ React — throws "Rules of Hooks" error')}`,
  `${K('export function')} ${M('Profile')}(props) {`,
  `  ${K('if')} (!props.user) ${K('return')} ${G('<EmptyState')} /${G('>')};`,
  ``,
  `  ${C('// ← Error: hooks cannot be called conditionally')}`,
  `  ${K('const')} [editing, setEditing] = useState(${K('false')});`,
  `  ${C('//  ^ React Error #001')}`,
  `  ${C('//    hooks must not be called after a conditional return')}`,
  ``,
  `  ${K('return')} ${G('<button')}${G('>...')}${G('</button>')};`,
  `}`,
].join('\n');

export function HooksAnywhereDemo() @{
  const [showUser, setShowUser] = useState(true);

  // This useState lives after the conditional above — works fine in OctaneJS
  const [editing, setEditing] = useState(false);

  <section id="hooks-demo" class="py-20">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 3'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'Zero Rules of Hooks'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{"OctaneJS tracks hooks by source location, not call order. Hooks can live after early returns or inside conditionals without crashing."}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-6">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo — this component IS the example'}</p>

          <div class="flex items-center gap-3">
            <span class="text-sm text-[#9898b2]">{'Simulate logged-in user:'}</span>
            <button
              onClick={() => { setShowUser(s => !s); setEditing(false); }}
              class={'px-4 py-2 rounded-xl text-sm font-mono border transition-all ' +
                (showUser
                  ? 'bg-emerald-500/10 border-emerald-500/30 text-emerald-400'
                  : 'bg-red-500/10 border-red-500/30 text-red-400')}
            >
              {showUser ? 'User: logged in' : 'User: null' as string}
            </button>
          </div>

          <div class="min-h-[140px] flex items-center justify-center bg-[#0d0d14] border border-white/7 rounded-xl p-6">
            @if (!showUser) {
              <p class="text-[#5a5a72] font-mono text-sm">{'<EmptyState /> — early return triggered'}</p>
            } @else {
              <div class="flex flex-col items-center gap-3 text-center">
                <p class="text-xs text-[#5a5a72] font-mono">{"useState(false) runs even though it's after the early-return guard"}</p>
                <button
                  onClick={() => setEditing(e => !e)}
                  class="px-5 py-2.5 rounded-xl bg-[#6c63ff] hover:bg-violet-500 text-white text-sm font-semibold transition-all"
                >
                  {editing ? 'Cancel editing' : 'Edit profile' as string}
                </button>
                @if (editing) {
                  <input
                    type="text"
                    placeholder="Edit your name…"
                    class="bg-[#111118] border border-violet-500/40 rounded-xl px-4 py-2 text-sm text-white font-mono outline-none w-full"
                  />
                }
              </div>
            }
          </div>

          <div class="px-4 py-3 bg-emerald-500/8 border border-emerald-500/20 rounded-xl">
            <p class="text-xs text-emerald-400 font-mono">{'✓ No crash. No reorder. Compiler assigns slots by call site, not call order.'}</p>
          </div>
        </div>

        {/* Code panels stacked */}
        <div class="flex flex-col gap-4">
          <CodePanel filename="Profile.tsrx — OctaneJS ✓" code={OCTANE_CODE as string} />
          <CodePanel filename="Profile.tsx — React ✗" code={REACT_CODE as string} />
        </div>
      </div>
    </div>
  </section>
}
