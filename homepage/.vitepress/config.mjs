import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  lang: "en-US",
  title: "Pseudovirus deep mutational scanning of SARS-CoV-2 spike from KP.3.1.1 strain",
  description:
    "Data, figures, and analysis for KP.3.1.1 spike .",
  base: "/SARS-CoV-2_KP.3.1.1_spike_DMS/",
  appearance: false,
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Home", link: "/" },
      { text: "Appendix", link: "/appendix", target: "_self" },
    ],
    socialLinks: [{ icon: "github", link: "https://github.com/dms-vep/SARS-CoV-2_KP.3.1.1_spike_DMS" }],
    footer: {
      message: 'See <a href="https://www.biorxiv.org/content/10.1101/2025.08.18.671001v1">Dadonaite et al (2025)</a> for study details',
    },
  },
});
