class AudioTranscriber {
    constructor() {
        this.selectedFiles = [];
        this.activeJobs = new Map();
        this.initEventListeners();
        this.loadExistingJobs();
        this.startPolling();
    }

    initEventListeners() {
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const uploadBtn = document.getElementById('uploadBtn');

        // Drag and drop handlers
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            this.handleFiles(e.dataTransfer.files);
        });

        // File input handler
        fileInput.addEventListener('change', (e) => {
            this.handleFiles(e.target.files);
        });

        // Upload button handler
        uploadBtn.addEventListener('click', () => {
            this.uploadFiles();
        });

        // Modal handlers
        const modal = document.getElementById('transcriptModal');
        const closeBtn = document.querySelector('.close');
        const copyBtn = document.getElementById('copyBtn');
        const downloadBtn = document.getElementById('downloadBtn');

        closeBtn.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        window.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });

        copyBtn.addEventListener('click', () => {
            this.copyToClipboard();
        });

        downloadBtn.addEventListener('click', () => {
            this.downloadTranscript();
        });
    }

    handleFiles(files) {
        this.selectedFiles = Array.from(files);
        this.displayFileInfo();
        
        const uploadBtn = document.getElementById('uploadBtn');
        uploadBtn.style.display = this.selectedFiles.length > 0 ? 'block' : 'none';
    }

    displayFileInfo() {
        const fileInfo = document.getElementById('fileInfo');
        
        if (this.selectedFiles.length === 0) {
            fileInfo.style.display = 'none';
            return;
        }

        fileInfo.style.display = 'block';
        fileInfo.innerHTML = '<h4>Selected Files:</h4>';
        
        this.selectedFiles.forEach(file => {
            const fileItem = document.createElement('div');
            fileItem.className = 'file-item';
            
            const icon = this.getFileIcon(file.type);
            const size = this.formatFileSize(file.size);
            
            fileItem.innerHTML = `
                <i class="${icon}"></i>
                <span>${file.name} (${size})</span>
            `;
            
            fileInfo.appendChild(fileItem);
        });
    }

    getFileIcon(fileType) {
        if (fileType.startsWith('audio/')) {
            return 'fas fa-music';
        } else if (fileType.startsWith('video/')) {
            return 'fas fa-video';
        }
        return 'fas fa-file';
    }

    formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    async uploadFiles() {
        if (this.selectedFiles.length === 0) return;

        const uploadBtn = document.getElementById('uploadBtn');
        uploadBtn.disabled = true;
        uploadBtn.textContent = 'Uploading...';

        try {
            for (const file of this.selectedFiles) {
                await this.uploadSingleFile(file);
            }
        } catch (error) {
            console.error('Upload error:', error);
            alert('Error uploading files: ' + error.message);
        } finally {
            uploadBtn.disabled = false;
            uploadBtn.textContent = 'Start Transcription';
            uploadBtn.style.display = 'none';
            this.selectedFiles = [];
            document.getElementById('fileInfo').style.display = 'none';
            document.getElementById('fileInput').value = '';
        }
    }

    async uploadSingleFile(file) {
        const formData = new FormData();
        formData.append('audioFile', file);

        const response = await fetch('/api/transcribe', {
            method: 'POST',
            body: formData
        });

        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.error || 'Upload failed');
        }

        const result = await response.json();
        console.log('Upload successful:', result);
        
        // Refresh jobs list
        this.loadExistingJobs();
    }

    async loadExistingJobs() {
        try {
            const response = await fetch('/api/jobs');
            const jobs = await response.json();
            this.displayJobs(jobs);
        } catch (error) {
            console.error('Error loading jobs:', error);
        }
    }

    displayJobs(jobs) {
        const jobsList = document.getElementById('jobsList');
        
        if (jobs.length === 0) {
            jobsList.innerHTML = `
                <div class="no-jobs">
                    <i class="fas fa-inbox"></i>
                    <p>No transcription jobs yet. Upload a file to get started!</p>
                </div>
            `;
            return;
        }

        jobsList.innerHTML = '';
        
        // Sort jobs by ID (newest first)
        jobs.sort((a, b) => b.id - a.id);
        
        jobs.forEach(job => {
            const jobElement = this.createJobElement(job);
            jobsList.appendChild(jobElement);
        });
    }

    createJobElement(job) {
        const jobDiv = document.createElement('div');
        jobDiv.className = 'job-item';
        jobDiv.setAttribute('data-job-id', job.id);

        const statusClass = `status-${job.status.replace('_', '-')}`;
        const statusText = job.status.replace('_', ' ').toUpperCase();

        jobDiv.innerHTML = `
            <div class="job-header">
                <div class="job-title">
                    <i class="${this.getFileIcon('')}"></i>
                    ${job.fileName}
                </div>
                <div class="job-status ${statusClass}">${statusText}</div>
            </div>
            
            ${job.status !== 'completed' && job.status !== 'error' ? `
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${job.progress}%"></div>
                </div>
                <div class="progress-text">${job.progress}%</div>
            ` : ''}
            
            ${job.error ? `
                <div class="error-message" style="color: #dc3545; margin-top: 10px;">
                    <i class="fas fa-exclamation-triangle"></i>
                    ${job.error}
                </div>
            ` : ''}
            
            <div class="job-actions">
                ${job.status === 'completed' ? `
                    <button class="btn btn-primary" onclick="transcriber.viewTranscript('${job.id}', '${job.fileName}')">
                        <i class="fas fa-eye"></i> View Transcript
                    </button>
                ` : ''}
                <button class="btn btn-danger" onclick="transcriber.deleteJob('${job.id}')">
                    <i class="fas fa-trash"></i> Delete
                </button>
            </div>
        `;

        return jobDiv;
    }

    async viewTranscript(jobId, fileName) {
        try {
            const response = await fetch(`/api/status/${jobId}`);
            const job = await response.json();
            
            if (job.transcript) {
                const modal = document.getElementById('transcriptModal');
                const modalTitle = document.getElementById('modalTitle');
                const modalTranscript = document.getElementById('modalTranscript');
                
                modalTitle.textContent = `Transcript - ${fileName}`;
                modalTranscript.textContent = job.transcript;
                
                // Store current transcript for copy/download
                this.currentTranscript = {
                    text: job.transcript,
                    fileName: fileName
                };
                
                modal.style.display = 'block';
            }
        } catch (error) {
            console.error('Error loading transcript:', error);
            alert('Error loading transcript');
        }
    }

    async deleteJob(jobId) {
        if (!confirm('Are you sure you want to delete this job?')) {
            return;
        }

        try {
            const response = await fetch(`/api/jobs/${jobId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                this.loadExistingJobs();
            } else {
                throw new Error('Failed to delete job');
            }
        } catch (error) {
            console.error('Error deleting job:', error);
            alert('Error deleting job');
        }
    }

    copyToClipboard() {
        if (this.currentTranscript && this.currentTranscript.text) {
            navigator.clipboard.writeText(this.currentTranscript.text).then(() => {
                const copyBtn = document.getElementById('copyBtn');
                const originalText = copyBtn.innerHTML;
                copyBtn.innerHTML = '<i class="fas fa-check"></i> Copied!';
                setTimeout(() => {
                    copyBtn.innerHTML = originalText;
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy:', err);
                alert('Failed to copy to clipboard');
            });
        }
    }

    downloadTranscript() {
        if (this.currentTranscript && this.currentTranscript.text) {
            const blob = new Blob([this.currentTranscript.text], { type: 'text/plain' });
            const url = URL.createObjectURL(blob);
            
            const a = document.createElement('a');
            a.href = url;
            a.download = `${this.currentTranscript.fileName}_transcript.txt`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            
            URL.revokeObjectURL(url);
        }
    }

    startPolling() {
        // Poll for job updates every 3 seconds
        setInterval(() => {
            this.loadExistingJobs();
        }, 3000);
    }
}

// Initialize the transcriber when the page loads
const transcriber = new AudioTranscriber();
