// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
function update_buttons() {
	$('.manage-button').each( (_, bb) => {
		let user_id = $(bb).data('user-id');
		let manage = $(bb).data('manage');
		if (manage != "") {
			$(bb).text("Unmanage");
		}
		else {
			$(bb).text("Manage");
		}
		});
	}

function set_button(user_id, value) {
	$('.manage-button').each( (_, bb) => {
		if (user_id == $(bb).data('user-id')) {
			$(bb).data('manage', value);
		}
	});
	update_buttons();
}

function manage(user_id) {
	let text = JSON.stringify({
		manage: {
			manager_id: current_user_id,
			managee_id: user_id
		},
	});

	$.ajax(manage_path, {
		method: "post",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		data: text,
		success: (resp)=>{ set_button(user_id, resp.data.id);}
	});
}

function unmanage(user_id, manage_id) {
	$.ajax(manage_path + "/" + manage_id, {
		method: "delete",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		data: "",
		success: () => { set_button(user_id, "");},
	});
}

function manage_click(ev) {
	let btn = $(ev.target);
	let manage_id = btn.data('manage');
	let user_id = btn.data('user-id');

	if(manage_id != "") {
		unmanage(user_id, manage_id);
	}
	else {
		manage(user_id);
	}
}

function init_manage() {
	if(!$('.manage-button')) {
		return;
	}

	$(".manage-button").click(manage_click);
	update_buttons();
}

function time_click(ev) {
	let btn = $(ev.target);
	let start = btn.data('start');
	if (start) {
		let text = JSON.stringify({
			timeblock: {
				start_time: new Date()
			}
		});
		console.log(text);

		$.ajax(timeblock_path, {
			method: "post",
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			data: text,
			success: (resp)=>{ 
				btn.data('start',false); 
			update_time(); }
		});
	} else {
		let text = JSON.stringify({
			timeblock: {
				end_time: new Date()
			}
		});
		console.log(text);

		$.ajax(timeblock_path, {
			method: "post",
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			data: text,
			success: (resp)=>{ 
				btn.data('start',false); 
			update_time(); }
		});
	}
}

function update_time() {
  $('.time-block-button').each( (_, bb) => {
		let start = $(bb).data('start');
		console.log(start);
		if (start != true) {
			$(bb).text("Stop");
		}
		else {
			$(bb).text("Start");
		}
	});
}

function init_time() {
  update_time();
  console.log(timeblock_path);
  $(".time-block-button").click(time_click);
}

$(init_manage);
$(init_time);

