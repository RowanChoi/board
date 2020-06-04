<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header" id="listHeader">전체보기</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			
			<button id='regBtn' type="button" class="btn btn-warning pull-right">새글쓰기</button>
		
			<div class="panel-body">
				<table class="table table-striped" style="text-align:center;">
					<thead>
						<tr>
							<th style="text-align:center; width:10%;">번호</th>
							<th style="text-align:center; width:55%;">제목</th>
							<th style="text-align:center; width:15%;">작성자</th>
							<th style="text-align:center; width:10%;">조회수</th>
							<th style="text-align:center; width:10%;">작성일</th>
						</tr>
					</thead>
					<tbody id="listTbody">
				</table>
			</div>
			<!-- /.panel-body -->

			<!-- 처리 완료 Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="111111" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">알림</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
			
			
			<!-- 새글쓰기 modal -->
			<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <%@include file="register.jsp"%>
			</div>
			
			<!-- 상세화면 modal -->
			<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <%@include file="detail.jsp"%>
			</div>
			

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		getList();
		
		$("#regBtn").click(function() {
			$("#registerModal").modal("show");
		});
		
		//register 안 click 메소드
		$("#uploadBtn").click(function(){
 			if(!checkRegisterValid()) return;
 			if(!confirm("새글을 등록하시겠습니까?")) return;
 			
 			var form = $("#registerForm")[0];
 			var formData = new FormData(form);
			var inputFile = $("#uploadFile");
			var files = inputFile[0].files;
			
			console.log("files : ", files);
 			
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name) || !checkFileSize(files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
 			var formSerialized = $("#registerForm").serialize();
 			console.log("formSerialized : ", formSerialized);
 			$.ajax({
 				url:"/board/register"
 				,processData: false
 				,contentType: false
 				,data: formData
 				,type: 'POST'
 				,dataType : 'json'
 				,success: function(result){
 					if (result[0] === "success") {
	 					console.log("result:",result);
	 					console.log(result[0]);
	 					console.log(result[1]);
	 					getList();
	 					alert( result[1] + " 번 글이 등록되었습니다.");
						$("#registerModal").modal("hide");
 					}
 				}
 			});
 		});//click
 		
 		//detail 안 메소드
		$("#modifyBtn").click(function() {
			
			$("#modifyBtn").hide();
			$("#updateBtn").show();
			
	        var title = $("#detailTbl2 td:eq(2)").text();
	        var content = $("#detailTbl2 td:eq(5)").text();
	        
			$("#detailTbl").remove();
			$("#detailTbl2 td:eq(2)").html('<input class="form-control" name="title" id="modifyTitle" value="'+title+'">');
			$("#detailTbl2 td:eq(5)").html('<textarea class="form-control" rows="15" name="content" id="modifyContent">'+content + "</textarea>");
			$.each($("#detailFiles a"), function(idx, value){
				$(value).after("<i class='glyphicon glyphicon-trash' style='margin-left:10px;cursor:pointer' onclick='javascript:removeFileBtn()'></i>");
			});
			
		});

		$("#updateBtn").click(function() {
			if(!checkModifyValid()) return;
			if(!confirm("수정 하시겠습니까?")) return;
			
			var serialized = $("form[name='modifyForm']").serialize();
			//console.log(serialized);

			$.ajax({
				url: "/board/modify"
				,data: serialized
				,type: "POST"
				,success: function(result){
					console.log("result:", result);
					if (result === "success") {
						getList();
						alert("수정 되었습니다.");
						$("#detailModal").modal("hide");
					} else {
						alert("수정이 실패 되었습니다.");
					}
				}
			});
		});
		
		$("#removeBtn").click(function() {
			alert("기능 준비중입니다.");
		});
		
		$("#closeBtn").click(function() {
			$("#detailModal").modal("hide");
		});
 		
	}); // end : $(document).ready
	
	function getList() {
		$.ajax({
            url : "/board/list"
            ,type: "get"
            ,success : function(result){
            	$("#listTbody").empty();
            	//console.log("list result : ", result);
            	var html = "";
            	var row = result.length;
            	$("#listHeader").text( $("#listHeader").text() + "(" + row + ")" ); 
            	if (result) {
	            	$.each(result, function(idx, value) {
	            		html = "<tr>";
	            		html += "<td>" + (row--) + "</td>";
	            		html += "<td align=\"left\">";
	            		html += "[" + value.category + "]";
	            		html += "<a href=\"javascript:moveDetail(" + value.bno + ");\" style=\"cursor:pointer\"> " + value.title + "</a>";
	            		if (value.fileCnt != '0') {
	            			html += "<i class=\"glyphicon glyphicon-paperclip\"></i>";
						}
	            		html += "</td>";
	            		html += "<td>" + value.writer + "</td>";
	            		html += "<td>" + value.hit + "</td>";
	            		html += "<td>" + value.regDateForm + "</td>";
	            		html += "</tr>";
	            		$("#listTbody").append(html);
	            	});
				} else {
            		$("#listTbody").append("<tr><td colspan=\"5\">검색 결과가 없습니다.</td></tr>");
				}
            } 
            ,error : function(){
               alert("상세화면 서버 접속 실패");
            }	
		})// end : $.ajax
		
	}
	
	function moveDetail(bno) {
		$("#updateBtn").hide();
		$("#modifyBtn").show();
		$.ajax({
            url : "/board/get"
            ,type: "get"
            ,data : "bno="+bno
            ,success : function(result){
               //console.log("result : ", result);
               $("#detailTbl td:eq(0)").html('<font style="color:gray;">글번호 </font> <font style="color:#6084e8;">'+result.bno+'</font>');
               $("#detailTbl td:eq(1)").html('<font style="color:gray;">작성일 </font>'+result.regdate);
               $("#detailTbl td:eq(2)").html('<font style="color:gray;">조회 </font>'+result.hit);
               $("#detailTbl2 td:eq(2)").text(result.title);
               $("#detailTbl2 td:eq(3)").text(result.writer);
               $("#detailTbl2 td:eq(5)").text(result.content);
              // console.log("result.files : ", result.files);
               var files = "";
               if(result.files != null ){
            	   $.each(result.files, function(idx, value) {
                	   var test = value.filePath + "\\" + value.fileName;
                	   test = test.substr( test.indexOf("resources") );
                	   files += "<a href =" + test + " download>" + value.originFileName + "</a><br>";
                   });
               } else {
            	   $("#trFilesTitle").hide();
            	   $("#trFilesContent").hide();
               }
               
               $("#detailFiles").html(files);
               $("#bno").val(result.bno);
               
               $("#detailModal").modal("show");
            } 
            ,error : function(){
               alert("상세화면 서버 접속 실패");
            }	
		})// end : $.ajax
	}
	
	function checkRegisterValid(){
 		if( is_empty('[name=category]') ){
 			alert("카테고리를 입력해주세요.");
 			$("[name=title]").focus();
 			return false;
 		}
 		if( is_empty('[name=title]') ){
 			alert("제목을 입력해주세요.");
 			$("[name=title]").focus();
 			return false;
 		}
 		if( is_empty('[name=writer]') ){
 			alert("작성자를 입력해주세요.");
 			$("[name=writer]").focus();
 			return false;
 		}
 		if( is_empty('[name=content]') ){
 			alert("내용을 입력해주세요.");
 			$("[name=content]").focus();
 			return false;
 		}
 		return true;
 	}
	
	
	function checkModifyValid(){
		if( is_empty("#modifyTitle") ){
			alert("제목을 입력해주세요.");
			$("#modifyTitle").focus();
			return false;
		}
		if( is_empty("#modifyContent") ){
			alert("내용을 입력해주세요.");
			$("#modifyContent").focus();
			return false;
		}
		return true;
	}

	function removeFileBtn() {
		alert("기능 준비중입니다.");
	}
</script>
