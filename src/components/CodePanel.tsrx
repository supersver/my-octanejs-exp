interface CodePanelProps {
  filename: string;
  code: string; // pre-formatted HTML string with <span> colour tags
}

export function CodePanel(props: CodePanelProps) @{
  <div class="min-w-0 bg-[#0d0d14] border border-white/10 rounded-2xl overflow-hidden font-mono text-xs leading-relaxed">
    {/* Traffic lights header */}
    <div class="flex items-center gap-2 px-4 py-3 border-b border-white/7 bg-[#111118]">
      <span class="w-3 h-3 rounded-full bg-red-500/70"></span>
      <span class="w-3 h-3 rounded-full bg-yellow-500/70"></span>
      <span class="w-3 h-3 rounded-full bg-green-500/70"></span>
      <span class="ml-3 text-[11px] text-[#5a5a72] tracking-wide">{props.filename as string}</span>
    </div>
    {/* Code body */}
    <pre
      class="max-w-full max-h-[32rem] p-5 overflow-auto text-[#9898b2] whitespace-pre"
      dangerouslySetInnerHTML={{ __html: props.code }}
    ></pre>
  </div>
}
