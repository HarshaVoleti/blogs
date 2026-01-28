#!/bin/bash

# VitePress blog setup and deployment script

# Install dependencies
npm install vitepress

# Create necessary directories
mkdir -p docs/blog
mkdir -p docs/public

# Copy markdown files from blogs directory to docs/blog
cp blogs/*.md docs/blog/ 2>/dev/null || true

# Add frontmatter to blog posts if missing
find docs/blog -name "*.md" -type f | while read -r FILE; do
  BASE=$(basename "$FILE" .md)
  
  # Skip README and index files
  if [[ "$BASE" != "README" && "$BASE" != "index" ]]; then
    # Check if file already has frontmatter (starts with ---)
    if ! head -1 "$FILE" | grep -q "^---"; then
      # Add frontmatter with title and date
      TITLE="${BASE//_/ }"
      DATE=$(date -u +"%Y-%m-%d")
      
      {
        echo "---"
        echo "title: $TITLE"
        echo "date: $DATE"
        echo "---"
        echo ""
        cat "$FILE"
      } > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
    fi
  fi
done

# Create VitePress config if it doesn't exist
if [ ! -f "docs/.vitepress/config.js" ]; then
  mkdir -p docs/.vitepress
  
  cat > docs/.vitepress/config.mjs << 'EOF'
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
          items: []
        }
      ]
    }
  }
})
EOF
fi

# Create blog index if it doesn't exist
if [ ! -f "docs/blog/index.md" ]; then
  cat > docs/blog/index.md << 'EOF'
# Blog

Welcome to the blog. Check out the latest posts below.
EOF
fi

# Create home page if it doesn't exist
if [ ! -f "docs/index.md" ]; then
  cat > docs/index.md << 'EOF'
---
layout: home

hero:
  name: "My Blog"
  text: "Welcome"
  tagline: Reading and writing
  actions:
    - theme: brand
      text: Read Blog
      link: /blog/
---
EOF
fi

echo "✓ VitePress blog setup complete!"