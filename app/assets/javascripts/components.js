var userDropdown = document.getElementById("user-dropdown");
function showDropdown() {
    userDropdown.classList.toggle("show");
}

window.onclick = function(event) {
    if (!event.target.matches('.mb-dropdown-btn')) {
        if (userDropdown.classList.contains("show")) {
            userDropdown.classList.remove("show");
        }
    }
}

var toggleLeftBtn = document.getElementById("toggle-left");
var leftBlock = document.getElementById("sidebar");
var centerBlock = document.getElementById("workspace");
var rightBlock = document.getElementById("todobar");

function hideLeft() {
    leftBlock.classList.remove("width-22");
    leftBlock.classList.add("hidden");
    centerBlock.classList.remove("width-48");
    centerBlock.classList.add("width-59");
    rightBlock.classList.remove("width-30");
    rightBlock.classList.add("width-41");
}

function showLeft() {
    leftBlock.classList.add("width-22");
    leftBlock.classList.remove("hidden");
    centerBlock.classList.add("width-48");
    centerBlock.classList.remove("width-59");
    rightBlock.classList.add("width-30");
    rightBlock.classList.remove("width-41");
}