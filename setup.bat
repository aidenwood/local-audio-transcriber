@echo off
echo 🚀 Local Audio Transcriber Setup Script
echo =======================================

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✅ Node.js is already installed: %NODE_VERSION%
) else (
    echo ❌ Node.js is not installed. Installing now...
    echo 🪟 Detected Windows - Downloading Node.js installer...
    
    REM Download and install Node.js
    echo Please download and install Node.js from: https://nodejs.org/
    echo After installation, please run this script again.
    echo.
    echo Or install via Chocolatey if you have it:
    echo choco install nodejs
    echo.
    echo Or install via winget:
    echo winget install OpenJS.NodeJS
    pause
    exit /b 1
)

REM Check if npm is available
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm is not available. Please reinstall Node.js from https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✅ npm is available: %NPM_VERSION%

echo.
echo 📦 Installing project dependencies...
npm install

if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies. Please check the error messages above.
    pause
    exit /b 1
)

echo ✅ Dependencies installed successfully!
echo.
echo                                                                                                  
echo                                                      #+%*#%*%%%%                             
echo                                                      %=##+%**##%                             
echo                                                       #  %%%                                 
echo                                                      %%+*#+#*+#*#%#%                        
echo                                                     **%#*%**#+##**+%                        
echo                                                     %%  %%%%%%%%                            
echo                                           ##%**%%#%%%*#%*#**#+##*%##%                       
echo                                           ##%++%###%#+*%+**+#**#+###%                       
echo                                                    %   %  %%  %%%%%%%                       
echo                                          #%  ##%*#%%%%%%##**#+##*%+#%#%                     
echo                                          ##%*+#*#**%#%%*##+#**#+#*+**%                      
echo                                                                  %%@%%%%@%%@%                
echo                                                  %%%*%%*#%##%%*+#*+#+**=#**%##              
echo                                                  %%%*#%++%####%*##+#*+#+*++%##              
echo                                                                    %%  %  %%                 
echo                                                        %#%%###%##%#+#+#*+%**%**              
echo                                                        %#%%######%#*#++#=##=%*#              
echo                                      %%                                  %%@#%@%@             
echo                           %%%###**#+###%##        %#%##%##%+##+%*+%+#%#%                     
echo                           %#%#*#%*#*+**%%#        %####%%#%**#+#%+%*+#*%                     
echo                    %   %%%  %%%%%@%%@%  %  %   @@%@%                   %%  %%                
echo                %###+#++#=*#+#++*+**+#+**=#+*%=**=#+*%+*####%%%%***+%++%=*#***#%              
echo                %#*%*+#=#**#+**+*+*#+#++*+##+%+=#+***#*#####%%##*##+##+%++*+#*#%              
echo                          %   %%%%%@%%@%%   %  %   @%@%%@%%                   %%              
echo                %###+%*+%+##+%**#+#**%+#*+%+#%=%*+%+#%+#**#+##+*****%*+%+#*+%**##%            
echo                %##%+*#=#**#+**+#+*#+#+*#=##+%++#=#**%+**+#**#*#####%**%++#+#*#%##            
echo               %%   %  %    %  %%  @   %  @@%  #  %%%  %%@%@%%@%@%%  %% %                     
echo           %##*+###   #%##%%              #%%*#%**#=%+*#+#*+#+#*+#+*#=%*+%+#%*#**#*#          
echo           %#%%*###   #%%#%               #%%##%###+##*%**#+#*##*#**#+##+%**#*#**###          
echo          %@%%%%%%%@%%                             %   %%%%%%%%%%%%%@%%%%%%%%%%              
echo        %#+**#*+#+*#+#**%                         #%####+****+#**#+**+%+*%+#*+#+*#+##*%       
echo        %###***+#*+%+***%                         ##%##%#####*##+#++#+#*+%++#+#*+#+*##%       
echo                   %%%%@%  #                              %%@%%%%@%%@%%@%@%%@%@%%@%%          
echo        %%##***+%+##+%*+%+*                            %+***#+#**%+##+%**%=##+%**#+####%%%    
echo        %%###%#+#**%+##=%##                            %%%#*#*##*#**#+##+%+*#+##*#**%%##%%    
echo                     %%@#  #@%%                            %%%%#@%%%%%#%@#%%%@#%%#@%%         
echo             %#%#*%+*%+#*=%+*%*#                  *#%**%+#*+#+#*+#+*#=#*+%+*#+#**#*###%       
echo             %%%##%#*%*##+###%#%                  #%%*#%*##*####*#**#*##*%**#*##*%##%%%       
echo              %%@%@%%%#%%#%%%%#%%#%%  %%@%%  %%@%%%%#%%#%#%%%%#%%#%%#@#%@%%%%@%%              
echo             %%#**#*##+%*+%+##+#**#+*####%#**==*++**#*#%*#**#*##*#+#*+%**%+##+*+*##%          
echo             %%%##%**%+##+%**#*#**##%%#%%###%##%%%##%**%*##*#*##*#**#+##+%+*##%##%%%          
echo                        %@%#@%%%%@%#%%%%%@#%%#%%%@#%%#@%%%%%%#%%%%%%#%%#%%%@#%                
echo                    %*%%*##+%+*#+#*+#+#**#+*#=%**%=##=%**%+#*+#+#**%+*#=%*+%+##*#*#%%%%       
echo                    %%%%%%%+%*#%*#*+%*##*%*#%+%#*%+#%+%#*%*##*%*##*%*#%+%#*%*#%#%%%%%%        
echo                           %@%%%#%#*%##%#%*#%*%%#@*%%*%%#%#%##%##%#%##%*%%#@%%@%%%%@           
echo                       %*%#*#+*%*#*+#+*#*#+*#=##+%+*#=#**%+**+#*##*#**#+##+%**#*##%%          
echo                       %%%##%##%###*%####%*##*%##%*#%*%##%###*%##%#%*#%*%%*%%%%#%%%           
echo                          %%@%%%%%%%%%%%#%##%*%##%*%%*%##%#%##%#%%#%##%%%%%@%%%%%             
echo                          ##%+##++***+*#*#**#+#**%+*#+#**%*#*+#*##*#***+*++#+*#*%             
echo                          %%%%%%%%%%%#%##%*##+%#*%*##+%##%*##*#*##*%*#%#%%%@%%%%%             
echo                              %%%@%%%%%%%%%%%%%%%%%*%%%@%%%%%%%%%%%%%%%%%@%%                  
echo                            %%%#*##*##+#####%++%##%=%**%*####*##+#####%*##%#%                 
echo                             %%%%%%%%%%%%%%%%%%%%%%*%%#%%%%%%%%%%%%%%%@%%%%%                  
echo                                   %%%%%%%%%%%@%%@%%%%%%%%%%%%%%%%                            
echo                              %%%#%#**%*#%*%**%+#%#####*#%%#%#%                               
echo                               %%%%%%%%%%%@%%%%%%%%%%%%%%%%%%%                                 
echo                                                                                                
echo.
echo                                    GOT EM!
echo.
echo 🎬 Starting Local Audio Transcriber...
echo 📋 The application will be available at: http://localhost:3000
echo 🔥 Press Ctrl+C to stop the server
echo.

REM Start the application
npm start
