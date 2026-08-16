import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, M, G, C, O } from '../lib/highlight.ts';

const CODE = [
  `${C('// class={[...]} — composes like clsx, built-in')}`,
  `${K('export function')} ${M('Card')}({ active, selected, featured }) ${K('{')}`,
  `  ${K('return')} (`,
  `    ${G('<article')}`,
  `      class={[`,
  `        ${S("'card'")},`,
  `        active    && ${S("'card--active'")},`,
  `        featured  && ${S("'card--featured'")},`,
  `        { selected },   ${C('// object form')}`,
  `      ]}`,
  `    ${G('>')}`,
  `      …`,
  `    ${G('</article>')}`,
  `  );`,
  `${K('}')}`,
  ``,
  `${C('// React turns ["a","b"] → "a,b" (wrong)')}`,
  `${C('// Octane produces "a b"      (correct)')}`,
].join('\n');

const FLAGS = [
  { key: 'active',   label: 'active',   cls: 'card--active' },
  { key: 'featured', label: 'featured', cls: 'card--featured' },
  { key: 'selected', label: 'selected', cls: 'card--selected' },
] as const;

type FlagKey = typeof FLAGS[number]['key'];

export function ClassArrayDemo() @{
  const [flags, setFlags] = useState<Record<FlagKey, boolean>>({
    active: false, featured: false, selected: false,
  });

  const toggle = (k: FlagKey) =>
    setFlags(f => ({ ...f, [k]: !f[k] }));

  // Build the class array exactly as OctaneJS does
  const classArray = [
    'card',
    flags.active   && 'card--active',
    flags.featured && 'card--featured',
    { selected: flags.selected },
  ];
  const classStr = [
    'card',
    flags.active   ? 'card--active'   : '',
    flags.featured ? 'card--featured' : '',
    flags.selected ? 'selected'        : '',
  ].filter(Boolean).join(' ');

  <section id="class-demo" class="py-20">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 9'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'class={[...]} Array Syntax'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{"OctaneJS accepts arrays and objects for the class prop — like clsx, built in. React turns ['a','b'] into \"a,b\". OctaneJS produces \"a b\"."}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-5">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live class composer'}</p>

          {/* Toggles */}
          <div class="flex flex-wrap gap-2">
            @for (const f of FLAGS; key f.key) {
              <button
                onClick={() => toggle(f.key)}
                class={'px-4 py-2 rounded-xl text-sm font-mono border transition-all flex items-center gap-2 ' +
                  (flags[f.key]
                    ? 'bg-violet-500/15 border-violet-500/35 text-violet-300'
                    : 'border-white/7 text-[#5a5a72] hover:border-white/12 hover:text-white')}
              >
                <span class={'w-2 h-2 rounded-full ' + (flags[f.key] ? 'bg-violet-400' : 'bg-[#5a5a72]')}></span>
                {f.label as string}
              </button>
            }
          </div>

          {/* Preview card */}
          <div class={'p-6 rounded-2xl border-2 transition-all duration-200 text-center ' +
            (flags.active   ? 'border-violet-500 ' : 'border-white/10 ') +
            (flags.featured ? 'bg-gradient-to-br from-violet-500/15 to-transparent ' : 'bg-[#0d0d14] ') +
            (flags.selected ? 'ring-2 ring-emerald-400/50 ' : '')
          }>
            <p class="text-sm font-semibold text-white mb-1">{'Preview Card'}</p>
            <p class="text-xs text-[#5a5a72]">{'Reflects all active class flags'}</p>
            @if (flags.featured) {
              <span class="inline-block mt-2 px-2 py-0.5 rounded bg-violet-500/20 text-violet-300 text-[10px] font-mono">{'⭐ featured'}</span>
            }
            @if (flags.selected) {
              <span class="inline-block mt-2 ml-1 px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 text-[10px] font-mono">{'✓ selected'}</span>
            }
          </div>

          {/* Computed class string */}
          <div class="bg-[#0d0d14] border border-white/7 rounded-xl p-4 font-mono text-xs flex flex-col gap-2">
            <p class="text-[#5a5a72]">{'// Computed class attribute:'}</p>
            <p class="text-emerald-400 break-all">{'"' + classStr + '"' as string}</p>
            <div class="border-t border-white/7 pt-2 mt-1">
              <p class="text-[#5a5a72]">{'// React would produce (wrong):'}</p>
              <p class="text-red-400/60">{"\"" + ['card', flags.active && 'card--active', flags.featured && 'card--featured'].filter(Boolean).join(',') + "\""  as string}</p>
            </div>
          </div>
        </div>

        <CodePanel filename="Card.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
