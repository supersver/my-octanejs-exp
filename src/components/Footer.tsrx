export function Footer() @{
  <footer class="border-t border-white/7 mt-16 py-8">
    <div class="max-w-7xl mx-auto px-5 flex flex-wrap items-center justify-between gap-5">
      <div class="flex flex-col gap-3">
        <a
          href="https://github.com/supersver"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="Visit supersver on GitHub"
          class="group inline-flex w-fit items-center gap-3 rounded-xl border border-violet-500/25 bg-violet-500/5 px-3 py-2 transition-all hover:-translate-y-0.5 hover:border-violet-500/50 hover:bg-violet-500/10"
        >
          <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-gradient-to-br from-[#6c63ff] to-violet-400 font-mono text-sm font-bold text-white shadow-lg shadow-violet-500/20">{'S'}</span>
          <span class="flex flex-col leading-tight">
            <span class="font-mono text-[10px] uppercase tracking-widest text-[#5a5a72]">{'Created by'}</span>
            <span class="font-mono text-sm font-semibold text-violet-300 group-hover:text-violet-200">{'supersver'}</span>
          </span>
          <span class="font-mono text-xs text-[#5a5a72] transition-colors group-hover:text-violet-300">{'GitHub ↗'}</span>
        </a>

        <p class="font-mono text-xs text-[#5a5a72]">
        {'Built with '}
        <a href="https://octanejs.dev" target="_blank" rel="noopener noreferrer"
           class="text-violet-400 hover:text-violet-300 transition-colors">{'OctaneJS'}</a>
        {' + Tailwind v4 · This page IS the experiment.'}
        </p>
      </div>
      <div class="flex items-center gap-4">
        <a href="https://octanejs.dev/docs/quick-start" target="_blank" rel="noopener noreferrer"
           class="font-mono text-[11px] text-[#5a5a72] hover:text-violet-400 transition-colors">{'Quick Start'}</a>
        <a href="https://octanejs.dev/docs/differences-from-react" target="_blank" rel="noopener noreferrer"
           class="font-mono text-[11px] text-[#5a5a72] hover:text-violet-400 transition-colors">{'vs React'}</a>
        <a href="https://github.com/octanejs/octane" target="_blank" rel="noopener noreferrer"
           class="font-mono text-[11px] text-[#5a5a72] hover:text-violet-400 transition-colors">{'GitHub'}</a>
      </div>
    </div>
  </footer>
}
