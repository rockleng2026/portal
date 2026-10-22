var lines = '';
var retus = '';
var xmlHttp = false;
var ipm;
try {
    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {
    try {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
  } catch (e2) {
        xmlHttp = false;
  }
}
if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
    var xmlHttp = new XMLHttpRequest(); 
}

document.writeln("<style>.popmenu {position:absolute; background-color:#e9ffd8; border:1px solid #fed070; padding-left:5; width:330px;}</style>");
document.writeln("<div id=popMenu class=popmenu style='display:none' onmouseout='hideSelf(this, event)'></div>");
var popup_menu = null;
document.onclick = new Function("showPopupMenu(null)")

function showPopupMenu(el, m, hostip) {
	if (m) {
		ipm = m;
		m.style.display='';
		m.style.left = getPos(el,"Left") + el.offsetWidth + 2;
		m.style.top = getPos(el,"Top") + 1;
		m.innerHTML  = "正在获取IP地理位置...";

    		var post=hostip;
    		var sLocation = window.location.href;
    		var url = sLocation.substring(0, sLocation.lastIndexOf("/") + 1) + "InfoIp.asp?ip=" + post;
    		xmlHttp.open("GET", url, true);
    		xmlHttp.onreadystatechange = changedWriteLine;
    		xmlHttp.send(null);
		}
	if ((m!=popup_menu) && (popup_menu)) popup_menu.style.display = 'none';
	popup_menu = m;
}

function changedWriteLine(){
    	if (xmlHttp.readyState == 4) {
        var val=xmlHttp.responseText;
        ipm.innerHTML=val;
	}
}

function hidePopupMenu(el, m, e) {
	var cx, cy;
	if (!e) {
		cx = window.event.x;
		cy = window.event.y;
	} else {
		cx = e.clientX;
		cy = e.clientY;
	}

	if (el && m && m.style.display=='') {
		if ((document.body.scrollLeft + cx > el.offsetLeft) 
				&& (document.body.scrollLeft + cx < el.offsetLeft + el.offsetWidth) 
				&& (document.body.scrollTop + cy > el.offsetTop) 
				&& (document.body.scrollTop + cy < el.offsetTop + el.offsetHeight)
				|| (document.body.scrollLeft + cx > m.offsetLeft)                
				&& (document.body.scrollLeft + cx < m.offsetLeft + m.offsetWidth) 
				&& (document.body.scrollTop + cy > m.offsetTop)
				&& (document.body.scrollTop + cy < m.offsetTop + m.offsetHeight)) {
		} else {
			m.style.display = 'none';
		}
	}
}

function dn() {}

//////////////////////////////////////////////////////////////////////////

document.writeln("<style>.tipdiv {font-family:verdana, arial, helvetica; font-size:12px; color:black; background-color:lightyellow; border:black 1px solid; padding:1px;}</style>");
document.writeln("<div id=popTip class=tipdiv style='position:absolute;display:none;' onmouseout='hideSelf(this, event)'></div>");

var popup_tip = null;

function getPos(el,sProp) {
	var iPos = 0;
	while (el!=null) {
		iPos+=el["offset" + sProp];
		el = el.offsetParent;
	}
	return iPos;
}

function showTip(el, m, tipArr) {
	tipArray = eval(tipArr);
	if (tipArray.length>0) {
		if (m) {
			m.style.display='';
			m.style.left = getPos(el,"Left");
			m.style.top = getPos(el,"Top") + el.offsetHeight;
			var title = tipArray[0];
			var detail = tipArray[1];
			if (m.innerHTML.length<1) {
				m.innerHTML += "<table width=200 border=0 cellspacing=0 cellpadding=0 style='font-size:11px'>\
							<tr><td colspan=3 align=center><b><font color=green>" + title + "</font></b></td></tr>\
							<tr><td width=6></td><td width=186 height=1 bgcolor=black></td><td width=8></td></tr>\
							<tr><td colspan=3 height=2></td></tr>\
							<tr><td></td><td>" + detail + "</td><td></td></tr>\
						</table>";
			}
		}
	}
	if ((m!=popup_tip) && (popup_tip)) popup_tip.style.display = 'none';
	popup_tip = m;
}

var waitTimer = "";
var intervalSeconds = 2000;

function startTimer(el, m, tipArr) {
        if (waitTimer=="") {
                waitTimer = window.setInterval("showTip3(" + el + ", " + m + ", " + tipArr + ")", intervalSeconds);
        } else {
                stopTimer();
        }
}

function stopTimer() {
        if (waitTimer!="") {
                window.clearInterval(waitTimer);
                waitTimer = "";
        }
}

function showTip3(el, m, tipArr) {
	tipArray = eval(tipArr);
	if (tipArray.length>0) {
		if (m) {
			m.style.display='';
			m.style.left = getPos(el,"Left") + el.offsetWidth;
			m.style.top = getPos(el,"Top");
			var title = tipArray[0];
			var detail = tipArray[1];
			if (m.innerHTML.length<1) {
				m.innerHTML += "<table width=200 border=0 cellspacing=0 cellpadding=0 style='font-size:11px'>\
							<tr><td colspan=3 align=center><b><font color=green>" + title + "</font></b></td></tr>\
							<tr><td width=6></td><td width=186 height=1 bgcolor=black></td><td width=8></td></tr>\
							<tr><td colspan=3 height=2></td></tr>\
							<tr><td></td><td>" + detail + "</td><td></td></tr>\
						</table>";
				var dist2Bottom = document.body.scrollTop + document.body.offsetHeight - m.offsetTop;
				if (dist2Bottom < el.offsetHeight) {
					m.style.pixelTop = m.style.pixelTop - m.offsetHeight;
				} else if (dist2Bottom < m.offsetHeight) {
					m.style.pixelTop = m.style.pixelTop - m.offsetHeight + el.offsetHeight - 5;
					if (m.offsetTop < document.body.scrollTop) {
						m.style.pixelTop = m.style.pixelTop + document.body.scrollTop;
					}
				}
			}
		}
	}
	if ((m!=popup_tip) && (popup_tip)) popup_tip.style.display = 'none';
	popup_tip = m;
}

function showTip2(el, m, tipstr) {	
	if (tipstr.length > 1) {
		if (m) {
			m.style.display='';
			m.style.left = getPos(el,"Left") + el.offsetWidth;
			m.style.top = getPos(el,"Top") + el.offsetHeight;
			if (m.innerHTML.length<1) {
				m.innerHTML = tipstr;
			}
		}
	}
	if ((m!=popup_tip) && (popup_tip)) popup_tip.style.display = 'none';
	popup_tip = m;

}

function hideTip(el, m, e) {
	var cx, cy;
	if (!e) {
		cx = window.event.x;
		cy = window.event.y;
	} else {
		cx = e.clientX;
		cy = e.clientY;
	}

	if (el && m && m.style.display=='') {
		if ((document.body.scrollLeft + cx > el.offsetLeft) 
				&& (document.body.scrollLeft + cx < el.offsetLeft + el.offsetWidth) 
				&& (document.body.scrollTop + cy > el.offsetTop) 
				&& (document.body.scrollTop + cy < el.offsetTop + el.offsetHeight)
				|| (document.body.scrollLeft + cx > m.offsetLeft)                
				&& (document.body.scrollLeft + cx < m.offsetLeft + m.offsetWidth) 
				&& (document.body.scrollTop + cy > m.offsetTop)
				&& (document.body.scrollTop + cy < m.offsetTop + m.offsetHeight)) {
		} else {
			m.style.display = 'none';
			m.innerHTML = "";
		}
	}
}

function hideSelf(m, e) {	
	var cx, cy;
	if (!e) {
		cx = window.event.x;
		cy = window.event.y;
	} else {
		cx = e.clientX;
		cy = e.clientY;
	}

	if (m.style.display=='') {
		if ((document.body.scrollLeft + cx >= m.offsetLeft)                
		&& (document.body.scrollLeft + cx <= m.offsetLeft + m.offsetWidth) 
		&& (document.body.scrollTop + cy >= m.offsetTop)
		&& (document.body.scrollTop + cy <= m.offsetTop + m.offsetHeight)) {
		} else {
			m.style.display = 'none';
			m.innerHTML = "";
		}
	}
}
