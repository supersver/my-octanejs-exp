import { useState } from 'octane';
import { CodePanel } from '../components/CodePanel.tsrx';
import { K, S, D, M, G, O, C } from '../lib/highlight.ts';

interface Item { id: number; text: string; }

const CODE = [
  `${K('export function')} ${M('TodoList')}(props) ${D('@{')}`,
  `  ${G('<ul')} class="list"${G('>')}`,
  `    ${D('@for')} (${K('const')} todo ${K('of')} props.todos; ${K('key')} todo.id) {`,
  `      ${G('<li>')}`,
  `        {todo.label ${K('as')} ${K('string')}}`,
  `        ${G('<button')} onClick={() => remove(todo.id)}${G('>')}×${G('</button>')}`,
  `      ${G('</li>')}`,
  `    } ${D('@empty')} {`,
  `      ${G('<li')} class="empty"${G('>')}${S('No tasks yet')}${G('</li>')}`,
  `    }`,
  `  ${G('</ul>')}`,
  `${D('}')}`,
].join('\n');

let nextId = 1;

export function ForDemo() @{
  const [items, setItems] = useState<Item[]>([
    { id: nextId++, text: 'Learn OctaneJS' },
    { id: nextId++, text: 'Build fast UIs' },
  ]);
  const [input, setInput] = useState('');

  const add = () => {
    const t = input.trim();
    if (!t) return;
    setItems(prev => [...prev, { id: nextId++, text: t }]);
    setInput('');
  };

  const remove = (id: number) =>
    setItems(prev => prev.filter(i => i.id !== id));

  <section id="for-demo" class="py-20">
    <div class="max-w-7xl mx-auto px-5">
      <div class="mb-8">
        <span class="font-mono text-[11px] text-violet-400 bg-violet-500/10 border border-violet-500/25 px-3 py-1 rounded-full">{'Feature 1'}</span>
        <h2 class="text-3xl font-bold text-white mt-3 mb-1">{'@for + @empty'}</h2>
        <p class="text-[#9898b2] text-sm max-w-xl">{'Keyed list rendering with a built-in @empty branch for the zero-items case. Add and remove items to see it in action.'}</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Live demo */}
        <div class="bg-[#111118] border border-white/7 rounded-2xl p-6 flex flex-col gap-4">
          <p class="font-mono text-xs text-[#5a5a72] uppercase tracking-widest">{'Live demo'}</p>

          {/* Input */}
          <div class="flex gap-2">
            <input
              type="text"
              value={input as string}
              onInput={(e: Event) => setInput((e.currentTarget as HTMLInputElement).value)}
              onKeyDown={(e: KeyboardEvent) => { if (e.key === 'Enter') add(); }}
              placeholder="Add a task…"
              class="flex-1 bg-[#0d0d14] border border-white/10 rounded-xl px-4 py-2.5 text-sm text-white placeholder:text-[#5a5a72] font-mono outline-none focus:border-violet-500/50 transition-colors"
            />
            <button onClick={add}
                    class="px-4 py-2.5 bg-[#6c63ff] hover:bg-violet-500 text-white text-sm font-semibold rounded-xl transition-all">
              {'Add'}
            </button>
          </div>

          {/* List */}
          <div class="min-h-[180px] flex flex-col gap-2">
            @if (items.length === 0) {
              <div class="flex-1 flex items-center justify-center text-[#5a5a72] font-mono text-sm border border-dashed border-white/10 rounded-xl py-10">
                {'@empty — No tasks yet'}
              </div>
            } @else {
              @for (const item of items; key item.id) {
                <div class="flex items-center justify-between px-4 py-3 bg-[#16161f] border border-white/7 rounded-xl group">
                  <span class="text-sm text-[#9898b2] font-mono">{item.text as string}</span>
                  <button onClick={() => remove(item.id)}
                          class="text-[#5a5a72] hover:text-red-400 font-mono text-sm opacity-0 group-hover:opacity-100 transition-all">
                    {'×'}
                  </button>
                </div>
              }
            }
          </div>

          <p class="text-xs text-[#5a5a72] font-mono">{(items.length + ' item' + (items.length !== 1 ? 's' : '')) as string}</p>
        </div>

        {/* Code */}
        <CodePanel filename="TodoList.tsrx" code={CODE as string} />
      </div>
    </div>
  </section>
}
