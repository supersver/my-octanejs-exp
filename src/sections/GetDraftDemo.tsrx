import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, M, G, C, O } from '../lib/highlight.ts';

const CODE = [
  `${C('// useState returns a 3rd item: a stable getter')}`,
  `${K('const')} [draft, setDraft, getDraft] = useState(${S("''")}),`,
  ``,
  `${K('async function')} ${M('save')}() {`,
  `  setSaving(${K('true')});`,
  `  ${K('await')} fakeDelay(1200); ${C('// simulate network')}`,
  ``,
  `  ${C('// getDraft() reads the LATEST value —')}`,
  `  ${C('// even if the user typed more during the await')}`,
  `  ${K('const')} latest = getDraft();`,
  `  setSaved(latest);`,
  `  setSaving(${K('false')});`,
  `}`,
].join('\n');

export function GetDraftDemo() @{
  const [draft, setDraft, getDraft] = useState('');
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState<string | null>(null);

  const save = async () => {
    setSaving(true);
    // Simulated 1.2s network delay
    await new Promise<void>(res => setTimeout(res, 1200));
    // getDraft() always has the latest — not a stale closure
    const latest = getDraft();
    setSaved(latest);
    setSaving(false);
  };

  <section id="getdraft-demo" class="py-20">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 5'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'useState — 3rd Tuple Item'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{'getDraft() is a stable getter that always reads the latest scheduled state — even after an await. No stale closure bugs.'}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo — type, hit Save, then keep typing'}</p>

          <textarea
            value={draft as string}
            onInput={(e: Event) => setDraft((e.currentTarget as HTMLTextAreaElement).value)}
            placeholder="Type your draft here… then click Save and keep typing while it saves."
            rows={4}
            class="bg-[#0d0d14] border border-white/10 rounded-xl px-4 py-3 text-sm text-white font-mono placeholder:text-[#5a5a72] outline-none focus:border-violet-500/50 transition-colors resize-none"
          ></textarea>

          <button
            onClick={save}
            disabled={saving}
            class={'px-5 py-3 rounded-xl text-sm font-semibold transition-all ' +
              (saving
                ? 'bg-[#6c63ff]/40 text-violet-300 cursor-wait'
                : 'bg-[#6c63ff] hover:bg-violet-500 text-white hover:-translate-y-0.5')}
          >
            {saving ? '⏳ Saving (1.2s delay)…' : 'Save' as string}
          </button>

          @if (saved !== null) {
            <div class="px-4 py-3 bg-emerald-500/8 border border-emerald-500/20 rounded-xl">
              <p class="text-xs text-[#5a5a72] font-mono mb-1">{'Saved value (from getDraft() after await):'}</p>
              <p class="text-emerald-400 font-mono text-sm break-all">{'"' + saved + '"' as string}</p>
            </div>
          }

          <p class="text-xs text-[#5a5a72] font-mono">
            {"In React you'd need a ref to avoid the stale closure. Here getDraft() does it natively."}
          </p>
        </div>

        <CodePanel filename="AsyncSave.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
