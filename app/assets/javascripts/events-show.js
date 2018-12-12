var eventDetails = document.getElementById("event-details");
var buttonDetails = document.getElementById("event-details-btn");
var eventAttendees = document.getElementById("event-attendees");
var buttonAttendees = document.getElementById("event-attendees-btn");
var eventType = document.getElementById("event-type");
var buttonType = document.getElementById("event-type-btn");
var typeDropdownDiv = document.getElementsByClassName("select-selected");

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
            if (typeDropdownDiv.length == 0) {
                generateSelect();
            }
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

var clearBtn = document.getElementById("clear-events");
var displayBtn = document.getElementById("display-events");
var eventTasksCleaned = document.getElementById("event-tasks-cleaned");
var eventTasksAll = document.getElementById("event-tasks-all");
var alltimeTasksCleaned = document.getElementById("alltime-tasks-cleaned");
var alltimeTasksAll = document.getElementById("alltime-tasks-all");

        function cleanTasks() {
            eventTasksCleaned.classList.remove("hidden");
            eventTasksAll.classList.add("hidden");
            alltimeTasksCleaned.classList.remove("hidden");
            alltimeTasksAll.classList.add("hidden");
            clearBtn.classList.add("hidden");
            displayBtn.classList.remove("hidden");
        }

        function displayTasks() {
            eventTasksCleaned.classList.add("hidden");
            eventTasksAll.classList.remove("hidden");
            alltimeTasksCleaned.classList.add("hidden");
            alltimeTasksAll.classList.remove("hidden");
            clearBtn.classList.remove("hidden");
            displayBtn.classList.add("hidden");
        }

        function cleanTasksIndex() {
            alltimeTasksCleaned.classList.remove("hidden");
            alltimeTasksAll.classList.add("hidden");
            clearBtn.classList.add("hidden");
            displayBtn.classList.remove("hidden");
        }

        function displayTasksIndex() {
            alltimeTasksCleaned.classList.add("hidden");
            alltimeTasksAll.classList.remove("hidden");
            clearBtn.classList.remove("hidden");
            displayBtn.classList.add("hidden");
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
