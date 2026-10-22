var ran1;
var ran2;
var ran3;
var ran4;
function randomPic(width, height) {
	var img = document.getElementById("img1");
	ran1 = getNum(Math.floor(Math.random() * 36));
	ran2 = getNum(Math.floor(Math.random() * 36));
	ran3 = getNum(Math.floor(Math.random() * 36));
	ran4 = getNum(Math.floor(Math.random() * 36));
	img.src = "RandomGraphics2?width=" + width + "&height=" + height + "&r1=" + ran1 + "&r2=" + ran2 + "&r3=" + ran3 + "&r4=" + ran4;
}
function getNum(ran) {
	var num;
	switch (ran) {
	  case 0:
	  case 1:
	  case 2:
	  case 3:
	  case 4:
	  case 5:
	  case 6:
	  case 7:
	  case 8:
	  case 9:
		num = ran;
		break;
	  case 10:
		num = "A";
		break;
	  case 11:
		num = "B";
		break;
	  case 12:
		num = "C";
		break;
	  case 13:
		num = "D";
		break;
	  case 14:
		num = "E";
		break;
	  case 15:
		num = "F";
		break;
	  case 16:
		num = "G";
		break;
	  case 17:
		num = "H";
		break;
	  case 18:
		num = "I";
		break;
	  case 19:
		num = "J";
		break;
	  case 20:
		num = "K";
		break;
	  case 21:
		num = "L";
		break;
	  case 22:
		num = "M";
		break;
	  case 23:
		num = "N";
		break;
	  case 24:
		num = "O";
		break;
	  case 25:
		num = "P";
		break;
	  case 26:
		num = "Q";
		break;
	  case 27:
		num = "R";
		break;
	  case 28:
		num = "S";
		break;
	  case 29:
		num = "T";
		break;
	  case 30:
		num = "U";
		break;
	  case 31:
		num = "V";
		break;
	  case 32:
		num = "W";
		break;
	  case 33:
		num = "X";
		break;
	  case 34:
		num = "Y";
		break;
	  case 35:
		num = "Z";
		break;
	}
	return num;
}

function check() {
	var num = document.getElementById("randomNum").value;
	var num2 = ran1 + ran2 + ran3 + ran4;
	if (num.toUpperCase() == num2) {
		alert("验证码正确!");
	} else {
		alert("验证码错误!");
	}
	randomPic();
	document.getElementById("randomNum").value = "";
}

