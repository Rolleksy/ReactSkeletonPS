function CRS {
    param (
        [string]$folderName = "NewFolder"
    )
    
    $folderPath = Join-Path -Path $PWD -ChildPath $folderName
	$folderPublicPath = Join-Path -Path $folderPath -ChildPath "public"
	$folderSrcPath = Join-Path -Path $folderPath -ChildPath "src"
	$folderComponents = Join-Path -Path $folderSrcPath -ChildPath "components"
    
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath -Force
		New-Item -ItemType Directory -Path $folderPublicPath -Force
		New-Item -ItemType Directory -Path $folderSrcPath -Force
		New-Item -ItemType Directory -Path $folderComponents -Force
        
        # INDEX.HTML
        $indexHtmlFileContent = '<!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="style.css">
                <title>Document</title>
            </head>
            <body>
                <div id="root"></div>
            </body>
            </html>'
        
        $indexHtmlFileName = "index.html"
        
        $indexHtmlFilePath = Join-Path -Path $folderPublicPath -ChildPath $indexHtmlFileName
        Set-Content -Path $indexHtmlFilePath -Value $indexHtmlFileContent
        
        # INDEX.JS
        $indexJsFileContent = 'import react from "react";
        import reactDOM from "react-dom";
        import App from "./App";

        reactDOM.render(<App />, document.getElementById("root"));'
        
        $indexJsFileName = "index.js"
        
        $indexJsFilePath = Join-Path -Path $folderSrcPath -ChildPath $indexJsFileName
        Set-Content -Path $indexJsFilePath -Value $indexJsFileContent
        
        # APP.JS
        $appJsFileContent = 'import React from "react";

        const App = () => {
          return (
            <div>
				<h1>Welcome to my react skeleton!</h1>
				<p>Thanks for using it!</p>
			</div>
          );
        };

        export default App;'
        
        $appJsFileName = "App.js"
        
        $appJsFilePath = Join-Path -Path $folderSrcPath -ChildPath $appJsFileName
        Set-Content -Path $appJsFilePath -Value $appJsFileContent
        
        # STYLE.CSS
        $styleCssFileContent = '* {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }'
        
        $styleCssFileName = "style.css"
        
        $styleCssFilePath = Join-Path -Path $folderPublicPath -ChildPath $styleCssFileName
        Set-Content -Path $styleCssFilePath -Value $styleCssFileContent
        
        $currentPath = $folderPath
        
        try {
            Write-Host "Starting creation"
            
            # Wyświetlenie aktualnej ścieżki w celu sprawdzenia poprawności
            Write-Host "Current Path: $currentPath"
            
            # Ustawienie lokalizacji na nowo utworzony folder
            Set-Location $currentPath
            
            # Instalacja zależności przy użyciu pełnej ścieżki do npm (zakładając, że npm jest dostępne)
            npm i react
            npm i react-dom
            npm i react-scripts
            
			# Aktualizacja pliku package.json
            $packageJsonPath = Join-Path -Path $currentPath -ChildPath 'package.json'
            $packageJsonContent = '
				{
				  "dependencies": {
					"react": "^18.2.0",
					"react-dom": "^18.2.0",
					"react-scripts": "^5.0.1"
				  },
				  "scripts": {
					"start": "react-scripts start"
				  },
				  "browserslist": {
					"production": [
					  ">0.2%",
					  "not dead",
					  "not op_mini all"
					],
					"development": [
					  "last 1 chrome version",
					  "last 1 firefox version",
					  "last 1 safari version"
					]
				  }
				}
				'
				
            Set-Content -Path $packageJsonPath -Value $packageJsonContent
			
			
			
            Write-Host "Installed React"
        }
        catch {
            Write-Host "Error: $_"
        }
        finally {
            # Przywróć bieżącą lokalizację
            Set-Location $PWD
        }
    }
}
