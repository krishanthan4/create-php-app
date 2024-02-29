# Prompt user for project name
$projectName = Read-Host "Project Name"

# Create project directory
New-Item -ItemType Directory -Name $projectName -ErrorAction Stop | Out-Null
cd $projectName

# Create backend directory
New-Item -ItemType Directory -Name "backend" -ErrorAction Stop | Out-Null
cd "backend"

# Create public directories
New-Item -ItemType Directory -Name "public" -ErrorAction Stop | Out-Null
cd "public"
New-Item -ItemType Directory -Name "js" -ErrorAction Stop | Out-Null
New-Item -ItemType Directory -Name "css" -ErrorAction Stop | Out-Null
New-Item -ItemType Directory -Name "images" -ErrorAction Stop | Out-Null
cd "images"
New-Item -ItemType Directory -Name "user-input" -ErrorAction Stop | Out-Null
New-Item -ItemType Directory -Name "app-images" -ErrorAction Stop | Out-Null
cd ".."

# Create script.js in public/js
New-Item -ItemType File -Name "script.js" -ErrorAction Stop | Out-Null

# Create style.css in public/css
New-Item -ItemType File -Name "style.css" -ErrorAction Stop | Out-Null

cd ".."  # Back to the backend directory

# Create other directories and files
New-Item -ItemType Directory -Name "controller" -ErrorAction Stop | Out-Null
New-Item -ItemType Directory -Name "views" -ErrorAction Stop | Out-Null
cd "views"

# Create template.view.php in views
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP - template</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="overflow-hidden bg-white">
    <div class="w-full h-full flex flex-row justify-center relative">
        <img src="https://pbs.twimg.com/profile_images/815698345716912128/hwUcGZ41_400x400.jpg" class="absolute object-cover h-screen opacity-50" alt="">
    </div>
</body>
</html>
"@ | Out-File -FilePath "template.view.php"

cd ".."  # Back to the backend directory

# Create model directory
New-Item -ItemType Directory -Name "model" -ErrorAction Stop | Out-Null

# Create index.php in the backend directory
"<?php require_once './views/template.view.php'; ?>" | Out-File -FilePath "index.php"

# Create .env.local file
@"
# Edit this with your credentials
DATABASE_HOSTNAME = "localhost"
DATABASE_USERNAME = "root"
DATABASE_PASSWORD = ""
DATABASE = ""
DATABASE_PORT = "3306"
"@ | Out-File -FilePath ".env.local"

# Create .gitignore file
New-Item -ItemType File -Name ".gitignore" -ErrorAction Stop | Out-Null

# Create connection.php file
@"
<?php

class Database {

    public static \$connection;

    public static function setUpConnection(){
        if(!isset(self::\$connection)){
            \$hostname = getenv('DATABASE_HOSTNAME');
            \$username = getenv('DATABASE_USERNAME');
            \$password = getenv('DATABASE_PASSWORD');
            \$database = getenv('DATABASE');
            \$port = getenv('DATABASE_PORT');

            self::\$connection = new mysqli(\$hostname, \$username, \$password, \$database, \$port);

            if (self::\$connection->connect_error) {
                die("Connection failed: " . self::\$connection->connect_error);
            }
        }
    }

    // Rest of your code remains unchanged...
}
"@ | Out-File -FilePath "connection.php"

# Create function.php file
@"
<?php function dd(\$value){ echo "<pre>"; var_dump(\$value); echo "</pre>"; die(); } ?>
"@ | Out-File -FilePath "function.php"

Write-Host "PHP MVC created"

# Back to the project directory
cd ".."

# Create frontend using npm
Write-Host "Creating frontend using npm..."
npm create vite@latest "$projectName-frontend" | Out-Null
cd "$projectName-frontend"

# Install npm dependencies
Write-Host "Installing npm dependencies..."
npm install -D tailwindcss postcss autoprefixer | Out-Null
npx tailwindcss init -p | Out-Null

# Create tailwind.config.js
@"
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Out-File -FilePath "tailwind.config.js"

# Ask user for opening frontend or backend or both
$answer = Read-Host "Do you want to open frontend or backend or both"

if ($answer -eq 'f' -or $answer -eq 'front' -or $answer -eq 'frontend') {
    Write-Host "npm run dev"
    code .
} elseif ($answer -eq 'b' -or $answer -eq 'back' -or $answer -eq 'backend') {
    cd ".."  # Back to the project directory
    cd "backend"
    Write-Host "Opening backend..."
    code .
} elseif ($answer -eq 'both') {
    cd ".."  # Back to the project directory
    Write-Host "Opening both..."
    code .
}
