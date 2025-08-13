# Local Audio Transcriber

A localhost web application for transcribing audio and video files using AssemblyAI's powerful speech-to-text API.

## 🚀 Quick Start

**Just run one command:**

```bash
# macOS/Linux
./setup.sh

# Windows  
setup.bat

# If you already have Node.js
npm install && npm start
```

Then open: **http://localhost:3000**

## Features

- 🎵 **Multi-format Support**: Supports audio files (MP3, WAV, M4A, AAC, FLAC, OGG) and video files (MP4, MOV, AVI, MKV, FLV, WMV, WebM)
- 🎬 **Video Processing**: Automatically extracts audio from video files for transcription
- 📱 **Modern UI**: Clean, responsive interface with drag-and-drop file upload
- ⚡ **Real-time Progress**: Live progress tracking for uploads and transcription
- 📋 **Easy Export**: Copy transcripts to clipboard or download as text files
- 🔄 **Job Management**: View all transcription jobs with status updates

## Installation

### 🚀 **One-Command Setup (Recommended)**

**For macOS/Linux:**
```bash
./setup.sh
```

**For Windows:**
```batch
setup.bat
```

**Alternative one-liner (if you have Node.js):**
```bash
npm install && npm start
```

These scripts will automatically:
- Check if Node.js is installed
- Install Node.js if needed (macOS/Linux only - Windows users will get instructions)
- Install all dependencies
- Start the application

### 📋 **Manual Installation**

1. **Clone or download this project**
2. **Install Node.js** from https://nodejs.org/ (if not already installed)
3. **Install dependencies**:
   ```bash
   npm install
   ```

4. **Start the server**:
   ```bash
   npm start
   ```
   
   Or for development with auto-restart:
   ```bash
   npm run dev
   ```

5. **Open your browser** and go to: `http://localhost:3000`

## Usage

1. **Upload Files**: Drag and drop audio/video files onto the upload area, or click to browse and select files
2. **Start Transcription**: Click "Start Transcription" to begin processing
3. **Monitor Progress**: Watch real-time progress updates for each job
4. **View Results**: Once complete, click "View Transcript" to see the transcribed text
5. **Export**: Copy to clipboard or download transcripts as text files

## Supported File Formats

### Audio Files
- MP3, WAV, M4A, AAC, FLAC, OGG

### Video Files
- MP4, MOV, AVI, MKV, FLV, WMV, WebM

*Note: For video files, audio is automatically extracted before transcription.*

## File Size Limits

- Maximum file size: 100MB
- For larger files, consider compressing or splitting them before upload

## API Endpoints

The application provides several REST API endpoints:

- `POST /api/transcribe` - Upload and start transcription
- `GET /api/status/:jobId` - Get transcription job status
- `GET /api/jobs` - Get all transcription jobs
- `DELETE /api/jobs/:jobId` - Delete a transcription job

## Technologies Used

- **Backend**: Node.js, Express.js
- **AI Service**: AssemblyAI API
- **File Processing**: Multer, FFmpeg
- **Frontend**: Vanilla JavaScript, HTML5, CSS3
- **Icons**: Font Awesome

## Configuration

The AssemblyAI API key is configured in `server.js`. For production use, consider moving this to environment variables:

```javascript
const client = new AssemblyAI({
  apiKey: process.env.ASSEMBLYAI_API_KEY || "your-api-key-here"
});
```

## Troubleshooting

### Common Issues

1. **"Invalid file type" error**: Ensure your file is in a supported format
2. **Upload fails**: Check that the file is under 100MB
3. **Transcription fails**: Verify your AssemblyAI API key is valid and has credits
4. **Video processing issues**: Ensure FFmpeg is properly installed

### FFmpeg Installation

FFmpeg is included automatically via `ffmpeg-static`, but if you encounter issues:

**macOS**: `brew install ffmpeg`
**Ubuntu/Debian**: `sudo apt install ffmpeg`
**Windows**: Download from https://ffmpeg.org/download.html

## Development

To modify or extend the application:

1. **Backend logic**: Edit `server.js`
2. **Frontend interface**: Edit files in the `public/` directory
3. **Styling**: Modify `public/styles.css`
4. **Client-side logic**: Edit `public/script.js`

## License

MIT License - feel free to use and modify as needed.

## Support

For issues with:
- **AssemblyAI API**: Check [AssemblyAI documentation](https://www.assemblyai.com/docs/)
- **Application bugs**: Review the console logs for error details
