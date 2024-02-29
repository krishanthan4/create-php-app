#!/bin/bash

read -p "Project Name: " ProjectName

mkdir "$ProjectName"
cd "$ProjectName" || exit

mkdir backend
cd backend || exit

mkdir -p public/{js,css,images/{user-input,app-images}}
cd public/js
touch script.js
cd ..
cd css
touch style.css
cd ..
cd ..
mkdir controller
mkdir views
cd views || exit
cat << 'EOF' > template.view.php
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
EOF
cd ..

mkdir model
echo "<?php require_once './views/template.view.php'; ?>" > index.php

echo "# Edit this with your credentials
 DATABASE_HOSTNAME="localhost"
DATABASE_USERNAME="root"
DATABASE_PASSWORD=""
DATABASE=""
DATABASE_PORT="3306"
" > .env.local
touch .gitignore
cat << 'EOF' > connection.php
<?php

class Database{

    public static $connection;

 public static function setUpConnection(){
        if(!isset(Database::$connection)){
            $hostname = getenv('DATABASE_HOSTNAME');
            $username = getenv('DATABASE_USERNAME');
            $password = getenv('DATABASE_PASSWORD');
            $database = getenv('DATABASE');
            $port = getenv('DATABASE_PORT');  // assuming you have a DATABASE_PORT variable in your .env.local

            Database::$connection = new mysqli($hostname, $username, $password, $database, $port);

            if (Database::$connection->connect_error) {
                die("Connection failed: " . Database::$connection->connect_error);
            }
        }
    }
    private static function detectParamType($param){
        switch (gettype($param)) {
            case 'integer':
                return 'i';
            case 'double':
                return 'd';
            case 'string':
            default:
                return 's';
        }
    }

    private static function bindParams($stmt, $params){
        $types = '';
        $bindParams = array();

        foreach ($params as $param) {
            $types .= self::detectParamType($param);
            $bindParams[] = $param;
        }

        if (!empty($bindParams)) {
            $stmt->bind_param($types, ...$bindParams);
        }
    }

    public static function iud($q, $params = array()){
        Database::setUpConnection();
        $stmt = Database::$connection->prepare($q);

        if ($stmt === false) {
            return false;
        }

        if (!empty($params)) {
            self::bindParams($stmt, $params);
        }

        $stmt->execute();
        $stmt->close();

        return true;
    }

    public static function search($q, $params = array()){
        Database::setUpConnection();
        $stmt = Database::$connection->prepare($q);

        if ($stmt === false) {
            // Handle error
            return false;
        }

        if (!empty($params)) {
            self::bindParams($stmt, $params);
        }

        $stmt->execute();
        $resultset = $stmt->get_result();
        $stmt->close();

        return $resultset;
    }
}

?>
EOF

echo "<?php 
function dd($value){
echo "<pre>";
var_dump($value);
echo "</pre>";
die();
}
?>" > function.php

echo "PHP MVC created"

cd ..

npm create vite@latest "$ProjectName-frontend"
cd "$ProjectName""-frontend" || exit
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
cat << 'EOF' > tailwind.config.js
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
EOF

read -p "Do you want to open frontend or backend or both: " answer

if [[ "$answer" == "f" || "$answer" == "front" || "$answer" == "frontend" ]]; then
  echo "npm run dev"
  code .
elif [[ "$answer" == "b" || "$answer" == "back" || "$answer" == "backend" ]]; then
  cd ..
  cd backend || exit
  echo ""
  code .
elif [[ "$answer" == "both" ]]; then
  cd ..
  code .
fi
