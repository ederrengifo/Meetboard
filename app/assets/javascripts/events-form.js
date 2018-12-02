var textArea = document.getElementById('note-textarea');
 var csrfToken = document.querySelector('form').querySelector('[name=authenticity_token]').value
 var editor = new MediumEditor('.editable');
 var divArea = document.getElementById('populate-div');
 var saveCounter;
 divArea.oninput = function() {
    textArea.innerHTML = divArea.innerHTML;
    ShowNotice();
     if (saveCounter)
         clearTimeout(saveCounter);

     saveCounter = setTimeout(() => {
         fetch("<%= @event %>",
               {method: "PATCH",
                headers: {
                    "X-CSRF-Token": csrfToken,
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({event: {note: textArea.value}})}).then(ShowSaving()).then(DelayNotice())
     }, 1000);
 };
 
 


 var update_btn = document.getElementById("update-btn");
 var note_confirmation = document.getElementById("note-confirmation");
 var Delay

 textArea.setAttribute('style', 'height:' + (textArea.scrollHeight) + 'px;overflow-y:hidden;');
 textArea.addEventListener("input", OnInput, false);


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