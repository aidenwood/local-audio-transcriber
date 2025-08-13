#!/bin/bash

echo "🚀 Local Audio Transcriber Setup Script"
echo "======================================="

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Node.js is installed
if command_exists node; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js is already installed: $NODE_VERSION"
else
    echo "❌ Node.js is not installed. Installing now..."
    
    # Detect operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "🍎 Detected macOS - Installing Node.js via Homebrew..."
        
        # Check if Homebrew is installed
        if ! command_exists brew; then
            echo "Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # Install Node.js via Homebrew
        brew install node
        
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "🐧 Detected Linux - Installing Node.js..."
        
        # Try different package managers
        if command_exists apt-get; then
            # Ubuntu/Debian
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command_exists yum; then
            # CentOS/RHEL
            curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
            sudo yum install -y nodejs npm
        elif command_exists pacman; then
            # Arch Linux
            sudo pacman -S nodejs npm
        else
            echo "❌ Unsupported Linux distribution. Please install Node.js manually from https://nodejs.org/"
            exit 1
        fi
        
    else
        echo "❌ Unsupported operating system. Please install Node.js manually from https://nodejs.org/"
        exit 1
    fi
    
    # Verify installation
    if command_exists node; then
        NODE_VERSION=$(node --version)
        echo "✅ Node.js successfully installed: $NODE_VERSION"
    else
        echo "❌ Node.js installation failed. Please install manually from https://nodejs.org/"
        exit 1
    fi
fi

# Check if npm is available
if ! command_exists npm; then
    echo "❌ npm is not available. Please reinstall Node.js from https://nodejs.org/"
    exit 1
fi

NPM_VERSION=$(npm --version)
echo "✅ npm is available: $NPM_VERSION"

echo ""
echo "📦 Installing project dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully!"
else
    echo "❌ Failed to install dependencies. Please check the error messages above."
    exit 1
fi

echo ""
echo "🎬 Starting Local Audio Transcriber..."
echo "📋 The application will be available at: http://localhost:3000"
echo "🔥 Press Ctrl+C to stop the server"
echo ""

# Start the application
npm start
