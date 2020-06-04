<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<div class="modal-dialog">
	   <div class="modal-content">
	     <div class="modal-header">
	       <h3 class="modal-title" id="exampleModalLabel">상세 페이지</h3>
	       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	         <span aria-hidden="true">&times;</span>
	       </button>
	     </div>

		<div class="modal-body">
		<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		      <div class="panel-body">
		      	<table class="table table-striped table-bordered" id="detailTbl">
		      		<tr>
		      			<td width="40%"></td>
		      			<td></td>
		      			<td></td>
		      		</tr>
		      	</table>
		      	<form name="modifyForm" method="post" enctype="multipart/form-data">
			      	<table class="table table-striped table-bordered" id="detailTbl2">
			      		<tr>
			      			<td width="70%">제목</td>
			      			<td>작성자</td>
			      		</tr>
			      		<tr>
			      			<td></td>
			      			<td></td>
			      		</tr>
			      		<tr>
			      			<td colspan="2">내용</td>
			      		</tr>
			      		<tr>
			      			<td colspan="2" height="400em"></td>
			      		</tr>
			      		<tr id="trFilesTitle">
			      			<td colspan="2">첨부파일</td>
			      		</tr>
			      		<tr id="trFilesContent">
			      			<td colspan="2" id="detailFiles"></td>
			      		</tr>
			      	</table>
					<input type="hidden" id="bno" name="bno" value="">
			  </form>
			  <!-- </form> -->
		
			  <button type="button" id="modifyBtn" class="btn btn-success btn-icon-split">수정</button>
			  <button type="button" id="updateBtn" class="btn btn-success btn-icon-split">저장</button>
			  <button type="button" id="removeBtn" class="btn btn-danger btn-icon-split">삭제</button>
			  <button type="button" id="closeBtn" class="btn btn-info">닫기</button>
	
		      </div>
		      <!--  end panel-body -->
		    </div>
		    <!--  end panel-body -->
		  </div>
		  <!-- end panel -->
		</div>
		<!-- end row -->
		</div>
		<!-- end modal-body -->

	  </div>
	  <!-- end modal-dialog -->
	</div>
	<!-- end modal-content -->