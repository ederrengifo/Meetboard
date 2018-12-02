var showUpcomingBtn = document.getElementById("show-new-events");
var showPastBtn = document.getElementById("show-past-events");
var upcomingEvents = document.getElementById("new-events");
var pastEvents = document.getElementById("past-events");

function showPast() {
    upcomingEvents.classList.add("hidden");
    pastEvents.classList.remove("hidden");
    showUpcomingBtn.classList.remove("active");
    showPastBtn.classList.add("active");
}

function showUpcoming() {
    upcomingEvents.classList.remove("hidden");
    pastEvents.classList.add("hidden");
    showUpcomingBtn.classList.add("active");
    showPastBtn.classList.remove("active");
}