import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  lang: "en-US",
  title: "Deep mutational scanning of SARS-CoV-2 spike",
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
    socialLinks: [{ icon: "github", link: "https://github.com/dms-vep" }],
    footer: {
      message: "Copyright © 2025-present Bernadeta Dadonaite and Jesse Bloom",
    },
  },
});
