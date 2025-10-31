const componentNames = {
    0: 'Viso',
    1: 'Maschera',
    2: 'Capelli',
    3: 'Torso',
    4: 'Gambe',
    5: 'Zaino',
    6: 'Scarpe',
    7: 'Accessori',
    8: 'Maglietta',
    9: 'Giubbotto',
    10: 'Texture',
    11: 'Giacca'
};

let currentClothing = {};

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === 'openClothing') {
        document.getElementById('clothingMenu').style.display = 'flex';
        loadClothingData();
    }
});

function loadClothingData() {
    fetch(`https://${GetParentResourceName()}/getClothingData`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(data => {
        currentClothing = data;
        renderComponents();
    });
}

function renderComponents() {
    const componentList = document.getElementById('componentList');
    componentList.innerHTML = '';

    for (let i = 0; i <= 11; i++) {
        const component = currentClothing[i];
        const componentDiv = document.createElement('div');
        componentDiv.className = 'component-item';

        componentDiv.innerHTML = `
            <label>${componentNames[i]}</label>
            <div class="component-controls">
                <button onclick="changeComponent(${i}, -1, 0)">◀</button>
                <span id="comp-${i}">${component.current}</span>
                <button onclick="changeComponent(${i}, 1, 0)">▶</button>
                <button onclick="changeComponent(${i}, 0, -1)">T-</button>
                <span id="text-${i}">${component.texture}</span>
                <button onclick="changeComponent(${i}, 0, 1)">T+</button>
            </div>
        `;

        componentList.appendChild(componentDiv);
    }
}

function changeComponent(componentId, drawableChange, textureChange) {
    const component = currentClothing[componentId];

    let newDrawable = component.current + drawableChange;
    let newTexture = component.texture + textureChange;

    if (newDrawable < 0) newDrawable = component.max;
    if (newDrawable > component.max) newDrawable = 0;
    if (newTexture < 0) newTexture = 0;

    component.current = newDrawable;
    component.texture = newTexture;

    document.getElementById(`comp-${componentId}`).textContent = newDrawable;
    document.getElementById(`text-${componentId}`).textContent = newTexture;

    fetch(`https://${GetParentResourceName()}/changeClothing`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            componentId: componentId,
            drawableId: newDrawable,
            textureId: newTexture
        })
    });
}

function closeMenu() {
    document.getElementById('clothingMenu').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeClothing`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeMenu();
    }
});

function GetParentResourceName() {
    return window.location.hostname;
}
