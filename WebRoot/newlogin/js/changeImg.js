
function changeImg() {
	var imgSrc = $("#imgObj");
	var src = imgSrc.attr("src");
	imgSrc.attr("src", chgUrl(src));
}

function chgUrl(url) {
	var timestamp = (new Date()).valueOf();
	urlurl = url.substring(0, 17);
	if ((url.indexOf("?") >= 0)) {
		urlurl = url + "&t=" + timestamp;
	} else {
		urlurl = url + "?t=" + timestamp;
	}
	return urlurl;
}

function isRightCode() {
	var code = $("#veryCode").attr("value");
	$.ajax({type:"POST", url:"ResultServlet", data:"veryCode=" + code, success:callback});
}

function callback(data) {
	$("#info").html(data);
}

