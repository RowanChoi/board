// 입력양식이 비어 있거나 체크되어 있지 않다면 true 리턴 함수 선언
function is_empty(selector) {
	try {
		var flag = true;
		var obj = $(selector);
		if(obj.is(":checkbox") || obj.is(":radio") ) {
			if(obj.filter(":checked").length > 0) {
				flag = false;
			}
		} else {
			var tmp = obj.val();
			tmp = tmp.split(" ").join("");
			if(tmp!="") {
				flag = false;
			}
		}
		return flag;
	} catch(e) {
		alert("is_empty(' "+selector+" ') 함수에서 에러 발생!");
		return false;
	}
}

// 첨부파일 사이즈 체크
var MAX_SIZE = 5242880; //5MB
function checkFileSize(fileSize) {
	if (fileSize >= MAX_SIZE) {
		alert("파일 사이즈가 5MB를 초과합니다.");
		return false;
	}
	if (fileSize < 1) {
		return false;
	}
	return true;
}

// 파일 확장자 체크
var FILE_REGEX = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
function checkExtension(fileName) {
	if (FILE_REGEX.test(fileName)) {
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}