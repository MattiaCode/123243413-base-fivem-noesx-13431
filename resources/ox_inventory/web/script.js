let currentInventory = null;
let allItems = {};

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === 'openInventory') {
        currentInventory = data.inventory;
        allItems = data.items;
        document.getElementById('inventoryContainer').style.display = 'flex';
        updateInventoryDisplay();
    } else if (data.type === 'closeInventory') {
        document.getElementById('inventoryContainer').style.display = 'none';
    } else if (data.type === 'updateInventory') {
        currentInventory = data.inventory;
        allItems = data.items;
        updateInventoryDisplay();
    }
});

function updateInventoryDisplay() {
    if (!currentInventory) return;

    const weightProgress = document.getElementById('weightProgress');
    const weightText = document.getElementById('weightText');
    const inventoryGrid = document.getElementById('inventoryGrid');

    const weightPercentage = (currentInventory.weight / currentInventory.maxWeight) * 100;
    weightProgress.style.width = weightPercentage + '%';
    weightText.textContent = `${(currentInventory.weight / 1000).toFixed(2)} / ${(currentInventory.maxWeight / 1000).toFixed(2)} kg`;

    if (weightPercentage > 90) {
        weightProgress.classList.add('overweight');
    } else {
        weightProgress.classList.remove('overweight');
    }

    inventoryGrid.innerHTML = '';

    for (let i = 0; i < currentInventory.slots; i++) {
        const slot = document.createElement('div');
        slot.className = 'inventory-slot';

        const item = currentInventory.items[i];

        if (item) {
            slot.classList.add('has-item');
            slot.innerHTML = `
                <div class="item-name">${item.label}</div>
                <div class="item-count">${item.count}x</div>
                <div class="item-weight">${(item.weight * item.count / 1000).toFixed(2)} kg</div>
            `;
            slot.onclick = () => useItem(item.name);
        } else {
            slot.innerHTML = '<div class="empty-slot">Vuoto</div>';
        }

        inventoryGrid.appendChild(slot);
    }
}

function useItem(itemName) {
    fetch(`https://${GetParentResourceName()}/useItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            item: itemName
        })
    });
}

function closeInventory() {
    document.getElementById('inventoryContainer').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/closeInventory`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeInventory();
    }
});

function GetParentResourceName() {
    return window.location.hostname;
}
