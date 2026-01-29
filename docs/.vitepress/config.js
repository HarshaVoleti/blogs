import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "My Blog",
  description: "A VitePress blog",
  cleanUrls: true,
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Blog', link: '/blog/' }
    ],
    sidebar: {
      '/blog/': [
        {
          text: 'Blog Posts',
          items: [
            { text: 'Production Grade Architecture', link: '/blog/production_grade_architecture' }
          ]
        }
      ]
    },
    search: {
      provider: 'local'
    }
  }
})
