var eventDetails = document.getElementById("event-details");
var buttonDetails = document.getElementById("event-details-btn");
var eventAttendees = document.getElementById("event-attendees");
var buttonAttendees = document.getElementById("event-attendees-btn");
var eventType = document.getElementById("event-type");
var buttonType = document.getElementById("event-type-btn");

        function showDetails() {
            eventDetails.classList.toggle("hidden");
            buttonDetails.classList.toggle("active");
            eventAttendees.classList.add("hidden");
            buttonAttendees.classList.remove("active");
            eventType.classList.add("hidden");
            buttonType.classList.remove("active");
        }

        function showAttendees() {
            eventAttendees.classList.toggle("hidden");
            buttonAttendees.classList.toggle("active");
            eventDetails.classList.add("hidden");
            buttonDetails.classList.remove("active");
            eventType.classList.add("hidden");
            buttonType.classList.remove("active");
        }

        function showType() {
            eventType.classList.toggle("hidden");
            buttonType.classList.toggle("active");
            eventDetails.classList.add("hidden");
            buttonDetails.classList.remove("active");
            eventAttendees.classList.add("hidden");
            buttonAttendees.classList.remove("active");
        }

var eventTaskTab = document.getElementById("event-task-tab");
var allTasksTab = document.getElementById("all-tasks-tab");
var eventTaskBlock = document.getElementById("event-task-block");
var allTasksBlock = document.getElementById("all-tasks-block")

        function showEventTasks() {
            eventTaskBlock.classList.remove("hidden");
            allTasksBlock.classList.add("hidden");
            eventTaskTab.classList.add("active");
            allTasksTab.classList.remove("active");
        }

        function showAllTasks() {
            eventTaskBlock.classList.add("hidden");
            allTasksBlock.classList.remove("hidden");
            eventTaskTab.classList.remove("active");
            allTasksTab.classList.add("active");
        }

var toggleLeftBtn = document.getElementById("toggle-left");
var leftBlock = document.getElementById("sidebar");
var centerBlock = document.getElementById("workspace");
var rightBlock = document.getElementById("todobar");

        function toggleLeft() {
            toggleLeftBtn.classList.toggle("layout-active");
            leftBlock.classList.toggle("width-22");
            leftBlock.classList.toggle("hidden");
            centerBlock.classList.toggle("width-48");
            centerBlock.classList.toggle("width-59");
            rightBlock.classList.toggle("width-30");
            rightBlock.classList.toggle("width-41");
        }

var clearBtn = document.getElementById("clear-events");
var eventTasksCleaned = document.getElementById("event-tasks-cleaned");
var eventTasksAll = document.getElementById("event-tasks-all");
var alltimeTasksCleaned = document.getElementById("alltime-tasks-cleaned");
var alltimeTasksAll = document.getElementById("alltime-tasks-all");

        function cleanTasks() {
            eventTasksCleaned.classList.toggle("hidden");
            eventTasksAll.classList.toggle("hidden");
            alltimeTasksCleaned.classList.toggle("hidden");
            alltimeTasksAll.classList.toggle("hidden");
            clearBtn.classList.toggle("active");
        }

var ids=["general", "personal", "checkin"];
var typeDropdown = document.getElementById("help-types");
var generalType = document.getElementById("general");
var personalType = document.getElementById("personal");
var checkinType = document.getElementById("checkin");

        function changeType() {
            if (typeDropdown.value == "general") {
                generalType.classList.remove("hidden");
                personalType.classList.add("hidden");
                checkinType.classList.add("hidden");
            } else {
                if (typeDropdown.value == "personal") {
                    generalType.classList.add("hidden");
                    personalType.classList.remove("hidden");
                    checkinType.classList.add("hidden");
                } else {
                    if (typeDropdown.value == "checkin") {
                        generalType.classList.add("hidden");
                        personalType.classList.add("hidden");
                        checkinType.classList.remove("hidden");
                    };
                };
            };
        } 
