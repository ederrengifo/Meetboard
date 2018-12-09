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