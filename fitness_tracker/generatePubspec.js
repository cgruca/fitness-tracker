const fs = require("fs");
const path = require("path");

const assetsDir = path.join(__dirname, "assets", "exercises");
const pubspecFile = path.join(__dirname, "pubspec.yaml");

// Function to list all subdirectories in the given directory
function getSubdirectories(dirPath) {
  const items = fs.readdirSync(dirPath);
  const subdirectories = items.filter((item) => {
    const fullPath = path.join(dirPath, item);
    return fs.statSync(fullPath).isDirectory();
  });
  return subdirectories;
}

// Generate the pubspec.yaml content
function generatePubspecContent() {
  const subdirectories = getSubdirectories(assetsDir);

  let pubspecContent = `
flutter:
  assets:
    - assets/data/exercises.json
`;

  subdirectories.forEach((subdir) => {
    pubspecContent += `    - assets/exercises/${subdir}/\n`;
  });

  return pubspecContent;
}

// Write the generated content to pubspec.yaml
function writePubspec() {
  const pubspecContent = generatePubspecContent();

  fs.writeFileSync(pubspecFile, pubspecContent, "utf8");
  console.log("pubspec.yaml has been updated with asset entries.");
}

// Run the script
writePubspec();
