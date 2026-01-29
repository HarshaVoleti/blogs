import { defineConfig } from 'vitepress'
import { generateSidebar } from 'vitepress-sidebar'
export default defineConfig({
  title: "My Blog",
  description: "A VitePress blog",
  cleanUrls: true,
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Blog', link: '/blog/' }
    ],
    sidebar: generateSidebar([
      {
        documentRootPath: '/blog/'
      }
    ]),
    search: {
      provider: 'local'
    }
  }
})
