let progress = 0;
const progressBar = document.getElementById('progress');
const loadingText = document.getElementById('loadingText');

const handlers = {
    startInitFunctionOrder(data) {
        loadingText.textContent = 'Inizializzazione...';
        updateProgress(10);
    },
    initFunctionInvoking(data) {
        loadingText.textContent = `Caricamento: ${data.type}`;
        updateProgress(progress + 5);
    },
    startDataFileEntries(data) {
        loadingText.textContent = 'Caricamento risorse...';
        updateProgress(30);
    },
    performMapLoadFunction(data) {
        loadingText.textContent = 'Caricamento mappa...';
        updateProgress(50);
    },
    onLogLine(data) {
        loadingText.textContent = data.message || 'Caricamento...';
    }
};

window.addEventListener('message', function(e) {
    if (handlers[e.data.eventName]) {
        handlers[e.data.eventName](e.data);
    }
});

function updateProgress(value) {
    progress = Math.min(value, 100);
    progressBar.style.width = progress + '%';
}

setInterval(() => {
    if (progress < 90) {
        updateProgress(progress + 1);
    }
}, 300);
