function showAlert(msg, nivel) {
  hideAlerts();
  tipoAlertaActual = $("#alertMessage").attr("data-nivel_alerta");

  $("#alertMessage").removeData("nivel_alerta");
  $("#alertMessage").removeAttr("data-nivel_alerta");
  $("#alertMessage").removeClass(tipoAlertaActual);

  $("#alertMessage").data("nivel_alerta", nivel);
  $("#alertMessage").attr("data-nivel_alerta", nivel);
  $("#alertMessage").addClass(nivel);

  $("#alertMessage").show();
  $("#alertMessageContent").html(msg);
}

function askConfirmationAlert(msg, nivel, data = null) {
  hideAlerts();
  tipoAlertaActual = $("#alertConfirmarMessage").attr("data-nivel_alerta");
  
  $("#alertConfirmarMessage").removeData("nivel_alerta");
  $("#alertConfirmarMessage").removeAttr("data-nivel_alerta");
  $("#alertConfirmarMessage").removeClass(tipoAlertaActual);

  $("#alertConfirmarMessage").data("nivel_alerta", nivel);
  $("#alertConfirmarMessage").attr("data-nivel_alerta", nivel);
  $("#alertConfirmarMessage").addClass(nivel);

  $("#alertConfirmarMessageContent").html(msg);
  $("#alertConfirmarMessage").show();

  for (const [key, value] of Object.entries(data)) {
    $("#alertConfirmarMessage").data(key, value);
  }
}

function hideAlerts() {
  $("#alertMessageContent").html("");
  $("#alertConfirmarMessageContent").html();

  $("#alertMessage").hide();
  $("#alertConfirmarMessage").hide();
}

function showEntityDetailsModal(title, url) {
  $("#entityModalTitle").html(title);
  $("#modalDetails").load(url, function () {

       $("#partialViewModal").modal("show");

  });
}



function getCurrentLine(text__area) {    
    pos = document.getElementById(text__area).selectionStart;//$(textarea).getSelection().start; // fieldselection jQuery plugin
    textarea = "#" + text__area;
    taval = $(textarea).val();
    start = taval.lastIndexOf('\n', pos - 1) + 1;
    end = taval.indexOf('\n', pos);

    var last_line = false;

    if (end == -1) {
        end = taval.length;
        last_line = true;
    }

    var text = taval.substr(start, end - start);
    var result = { "text": text, "last_line": last_line };

    return result;
    //return taval.substr(start, end - start);
}


function ajax_post_request(remote_address, the_arguments,
           done_callback = null, fail_callback = null, always_callbak = null) {
    $.post(remote_address, the_arguments, function (results) {
        if (done_callback !== null) {
            console.log("results" + results);
            done_callback(results);
            //the_modal_dialog.style.display = "none";
        }
    }).fail(function () {
        console.log("AJAX error requesting: " + remote_address);
    }).always(function () {
        //alert("finished");
    });
}
