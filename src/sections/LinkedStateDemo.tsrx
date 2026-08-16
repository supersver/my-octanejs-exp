import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, M, G, C, O } from '../lib/highlight.ts';

const CODE = [
  `${K('import')} { useLinkedState } ${K('from')} ${S("'octane'")};`,
  ``,
  `${K('export function')} ${M('UserEditor')}({ users }) ${K('{')}`,
  `  ${K('const')} [userId, setUserId] = useState(users[0].id);`,
  `  ${K('const')} user = users.find(u => u.id === userId);`,
  ``,
  `  ${C('// Resets name whenever userId changes')}`,
  `  ${C('// No useEffect, no extra render, no ref')}`,
  `  ${K('const')} [name, setName] = useLinkedState(`,
  `    userId,              ${C('// source key')}`,
  `    () => user.name,     ${C('// derive initial value')}`,
  `  );`,
  ``,
  `  ${K('return')} (`,
  `    ${G('<input')} value={name} onInput={e => setName(e.target.value)} /${G('>')}`,
  `  );`,
  `${K('}')}`,
].join('\n');

const USERS = [
  { id: 1, name: 'Alice Johnson' },
  { id: 2, name: 'Bob Smith' },
  { id: 3, name: 'Carol White' },
];

export function LinkedStateDemo() @{
  const [userId, setUserId] = useState(1);
  const user = USERS.find(u => u.id === userId)!;

  // useLinkedState: name resets to user.name whenever userId changes
  // Normally this would require useEffect + setState — here it's one line.
  // Since useLinkedState isn't in the alpha runtime yet we simulate:
  const [name, setName] = useState(user.name);
  const [prevId, setPrevId] = useState(userId);
  if (prevId !== userId) {
    setPrevId(userId);
    setName(user.name);
  }

  <section id="linked-demo" class="py-20">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 7'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'useLinkedState'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{'Resets or derives local state when a source value changes — no useEffect, no extra render, no ref. One line instead of five.'}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo'}</p>

          <div>
            <p class="text-xs text-[#5a5a72] font-mono mb-2">{'Select a user — name field resets automatically:'}</p>
            <div class="flex flex-wrap gap-2">
              @for (const u of USERS; key u.id) {
                <button
                  onClick={() => setUserId(u.id)}
                  class={'px-4 py-2 rounded-xl text-sm font-mono border transition-all ' +
                    (userId === u.id
                      ? 'bg-violet-500/15 border-violet-500/35 text-violet-300'
                      : 'border-white/7 text-[#5a5a72] hover:border-white/12 hover:text-white')}
                >
                  {u.name as string}
                </button>
              }
            </div>
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-xs text-[#5a5a72] font-mono">{'Edit name (then switch user):'}</label>
            <input
              type="text"
              value={name as string}
              onInput={(e: Event) => setName((e.currentTarget as HTMLInputElement).value)}
              class="bg-[#0d0d14] border border-white/10 rounded-xl px-4 py-3 text-sm text-white font-mono outline-none focus:border-violet-500/50 transition-colors"
            />
          </div>

          <div class="flex flex-col gap-1.5 px-4 py-3 bg-[#0d0d14] border border-white/7 rounded-xl font-mono text-xs">
            <p class="text-[#5a5a72]">{'// current state'}</p>
            <p><span class="text-violet-400">{'userId'}</span><span class="text-[#5a5a72]">{' = '}</span><span class="text-emerald-400">{(userId + '') as string}</span></p>
            <p><span class="text-violet-400">{'name'}</span><span class="text-[#5a5a72]">{' = '}</span><span class="text-emerald-400">{"'" + name + "'" as string}</span></p>
          </div>

          <div class="px-4 py-3 bg-[#6c63ff]/8 border border-violet-500/20 rounded-xl">
            <p class="text-xs text-violet-400 font-mono">{'const [name, setName] = useLinkedState(userId, () => user.name)'}</p>
          </div>
        </div>

        <CodePanel filename="UserEditor.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
