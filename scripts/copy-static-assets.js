const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const sourceDir = root;
const targetDir = path.join(root, 'public');

function copyRecursive(src, dest) {
  if (!fs.existsSync(src)) return;

  fs.mkdirSync(dest, { recursive: true });
  const entries = fs.readdirSync(src, { withFileTypes: true });

  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    if (entry.isDirectory()) {
      if (['.git', '.github', 'node_modules', 'dist', 'public'].includes(entry.name)) {
        continue;
      }
      copyRecursive(srcPath, destPath);
    } else if (entry.isFile()) {
      const shouldCopy = /\.(html|css|js|png|jpg|jpeg|gif|webp|ico|apk|md|json|glb|gltf|bin)$/i.test(entry.name);
      if (shouldCopy) {
        fs.copyFileSync(srcPath, destPath);
      }
    }
  }
}

copyRecursive(sourceDir, targetDir);
