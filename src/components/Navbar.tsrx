import { useState, useEffect } from 'octane';

const FEATURES = [
  { label: '@for',          href: '#for-demo'          },
  { label: '@if/@switch',   href: '#conditional-demo'  },
  { label: 'Hooks Anywhere',href: '#hooks-demo'         },
  { label: 'Auto Deps',     href: '#effect-demo'        },
  { label: 'getDraft',      href: '#getdraft-demo'      },
  { label: '@try/@catch',   href: '#trycatch-demo'      },
  { label: 'useLinkedState',href: '#linked-demo'        },
  { label: 'Perf',          href: '#perf-demo'          },
  { label: 'class[]',       href: '#class-demo'         },
];

export function Navbar() @{
  const [scrolled, setScrolled] = useState(false);
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const h = () => setScrolled(window.scrollY > 40);
    window.addEventListener('scroll', h, { passive: true });
    return () => window.removeEventListener('scroll', h);
  });

  <header class={
    'fixed top-0 left-0 right-0 z-50 transition-all duration-200 ' +
    (scrolled ? 'py-2 bg-[#0a0a0f]/90 backdrop-blur-xl border-b border-white/7' : 'py-4')
  }>
    <div class="max-w-7xl mx-auto px-5 flex items-center justify-between gap-4">
      <a href="#" class="font-mono font-bold text-base text-white flex items-center gap-2 flex-shrink-0" onClick={() => setOpen(false)}>
        <span class="px-2 py-0.5 rounded bg-[#6c63ff]/20 border border-[#6c63ff]/40 text-violet-300 text-xs">
          {'OctaneJS'}
        </span>
        <span class="text-[#5a5a72] font-normal hidden sm:block">{'Feature Showcase'}</span>
      </a>

      {/* Desktop links */}
      <nav class="hidden lg:flex items-center gap-0.5 overflow-x-auto">
        @for (const f of FEATURES; key f.href) {
          <a href={f.href as string}
             class="px-2.5 py-1.5 rounded-lg text-[11px] font-mono font-medium text-[#5a5a72] hover:text-violet-300 hover:bg-violet-500/10 transition-all whitespace-nowrap">
            {f.label as string}
          </a>
        }
      </nav>

      <div class="flex items-center gap-2">
        <a href="https://octanejs.dev" target="_blank" rel="noopener noreferrer"
           class="hidden sm:flex text-[11px] font-mono px-3 py-1.5 rounded-lg border border-violet-500/30 text-violet-400 hover:bg-violet-500/10 transition-all">
          {'Docs ↗'}
        </a>
        {/* Burger */}
        <button class="lg:hidden p-2 rounded-lg hover:bg-white/5 transition-all"
                onClick={() => setOpen(v => !v)} aria-label="Menu">
          <div class={'space-y-1.5 ' + (open ? 'opacity-0' : '')}>
            <span class="block w-5 h-0.5 bg-[#9898b2] rounded"></span>
            <span class="block w-5 h-0.5 bg-[#9898b2] rounded"></span>
            <span class="block w-3 h-0.5 bg-[#9898b2] rounded"></span>
          </div>
        </button>
      </div>
    </div>

    @if (open) {
      <div class="lg:hidden border-t border-white/7 bg-[#0a0a0f]/96 backdrop-blur-xl px-5 py-3 grid grid-cols-3 gap-1">
        @for (const f of FEATURES; key f.href) {
          <a href={f.href as string} onClick={() => setOpen(false)}
             class="px-3 py-2 rounded-lg text-[11px] font-mono text-[#9898b2] hover:text-violet-300 hover:bg-violet-500/10 transition-all text-center">
            {f.label as string}
          </a>
        }
      </div>
    }
  </header>
}
