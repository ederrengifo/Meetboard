 var update_btn = document.getElementById("update-btn");
 var note_confirmation = document.getElementById("note-confirmation");
 var Delay

 function OnInput() {
     this.style.height = 'auto';
     this.style.height = (this.scrollHeight) + 'px';
 }

 function ShowNotice() {
    note_confirmation.classList.remove("hidden");
    note_confirmation.classList.remove("saved");
    note_confirmation.innerHTML="Saving...";
 }

 function ShowSaving() {
    note_confirmation.classList.add("saved");
    note_confirmation.innerHTML="Saved"
 }

 function RemoveNotice() {
     note_confirmation.classList.add("hidden");
     note_confirmation.classList.remove("saved")
 }

 function DelayNotice() {
     Delay = setTimeout(RemoveNotice, 1800);
     
 }