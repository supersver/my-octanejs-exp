import "./styles/global.css";

import { Navbar } from "./components/Navbar.tsrx";
import { Footer } from "./components/Footer.tsrx";
import { Hero } from "./sections/Hero.tsrx";
import { ForDemo } from "./sections/ForDemo.tsrx";
import { ConditionalDemo } from "./sections/ConditionalDemo.tsrx";
import { HooksAnywhereDemo } from "./sections/HooksAnywhereDemo.tsrx";
import { EffectDemo } from "./sections/EffectDemo.tsrx";
import { GetDraftDemo } from "./sections/GetDraftDemo.tsrx";
import { TryCatchDemo } from "./sections/TryCatchDemo.tsrx";
import { LinkedStateDemo } from "./sections/LinkedStateDemo.tsrx";
import { PerfDemo } from "./sections/PerfDemo.tsrx";
import { ClassArrayDemo } from "./sections/ClassArrayDemo.tsrx";

export function App() @{
  <div class="min-h-screen bg-[#0a0a0f] text-[#f0f0f8] font-sans">
    <Navbar />
    <main class="pt-0">
      <Hero />
      <ForDemo />
      <ConditionalDemo />
      <HooksAnywhereDemo />
      <EffectDemo />
      <GetDraftDemo />
      <TryCatchDemo />
      <LinkedStateDemo />
      <PerfDemo />
      <ClassArrayDemo />
    </main>
    <Footer />
  </div>
}
