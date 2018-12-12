var userDropdown = document.getElementById("user-dropdown");
var shareDropdown = document.getElementById("export-dropdown");

function showDropdown() {
    userDropdown.classList.toggle("show");
}

function showShare() {
    shareDropdown.classList.toggle("show");
}

window.onclick = function(event) {
    if (!event.target.matches('.mb-dropdown-btn')) {
        if (shareDropdown.classList.contains("show")) {
            shareDropdown.classList.remove("show");
        } else if (userDropdown.classList.contains("show")) {
            userDropdown.classList.remove("show");
        }
    } 
}

var toggleLeftBtn = document.getElementById("toggle-left");
var showLeftBtn = document.getElementById("show-sidebar");
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
    showLeftBtn.classList.remove("hidden");
}

function showLeft() {
    leftBlock.classList.add("width-22");
    leftBlock.classList.remove("hidden");
    centerBlock.classList.add("width-48");
    centerBlock.classList.remove("width-59");
    rightBlock.classList.add("width-30");
    rightBlock.classList.remove("width-41");
    showLeftBtn.classList.add("hidden");
}

var x, i, j, selElmnt, a, b, c, z;

function generateSelect() {
    x = document.getElementsByClassName("custom-select");
    z = document.getElementById("custom-select-id");

    selElmnt = z.getElementsByTagName("select")[0];
    a = document.createElement("DIV");
    a.setAttribute("class", "select-selected");
    a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
    z.append(a);

    b = document.createElement("DIV");
    b.setAttribute("class", "select-items select-hide");
    for (j = 1; j < selElmnt.length; j++) {
        c = document.createElement("DIV");
        c.innerHTML = selElmnt.options[j].innerHTML;
        c.addEventListener("click", function(e) {
            var y, i, k, s, h;
            s = this.parentNode.parentNode.getElementsByTagName("select")[0];
            h = this.parentNode.previousSibling;
            for (i = 0; i < s.length; i++) {
                if (s.options[i].innerHTML == this.innerHTML) {
                    s.selectedIndex = i;
                    h.innerHTML = this.innerHTML;
                    y = this.parentNode.getElementsByClassName("same-as-selected");
                   for (k = 0; k < y.length; k++) {
                        y[k].removeAttribute("class");
                    }
                    this.setAttribute("class", "same-as-selected");
                    break;
                }
            }
            h.click();
        });
        b.appendChild(c);
    }

    z.appendChild(b);
    a.addEventListener("click", function(e) {
        e.stopPropagation();
        closeAllSelect(this);
        this.nextSibling.classList.toggle("select-hide");
        this.classList.toggle("select-arrow-active");
        changeType();
    });
}

function closeAllSelect(elmnt) {
    var x, y, i, arrNo = [];
    x = document.getElementsByClassName("select-items");
    y = document.getElementsByClassName("select-selected");
    for (i = 0; i < y.length; i++) {
        if (elmnt == y[i]) {
            arrNo.push(i)
        } else {
            y[i].classList.remove("select-arrow-active");
        }
    }
    for (i = 0; i < x.length; i++) {
        if (arrNo.indexOf(i)) {
            x[i].classList.add("select-hide");
        }
    }
}

document.addEventListener("click", closeAllSelect);
