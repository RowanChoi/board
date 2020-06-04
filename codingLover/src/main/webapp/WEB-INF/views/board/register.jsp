<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <div class="modal-dialog">
   <div class="modal-content">
     <div class="modal-header">
       <h3 class="modal-title" id="exampleModalLabel">새글등록</h3>
       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <span aria-hidden="true">&times;</span>
       </button>
     </div>
     
     <div class="modal-body">
     	<form id="registerForm" role="form" enctype="multipart/form-data">
     	  <div class="form-group">
     	    <label>카테고리</label><br>
			<input type="radio" name="category" value="1">notice
     		<input type="radio" name="category" value="2">자유게시판
			<input type="radio" name="category" value="3">갤러리
		  </div>
          <div class="form-group">
            <label>제목</label> <input class="form-control" name='title'>
          </div>
          <div class="form-group">
            <label>작성자</label> <input class="form-control" name='writer'>
          </div>
          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="3" name='content'></textarea>
          </div>
          <div class="form-group">
            <label>첨부파일</label> <label><font style="color:orange; font-size:1em;">(파일 크기는 최대 5MB까지입니다.)</font></label>
            <input type="file" class="form-control" id="uploadFile" multiple>
            
          </div>
          
          <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
       	  <button type="button" class="btn btn-default" id="uploadBtn">등록</button>
          <button type="reset" class="btn btn-default">초기화</button>
        </form>
     </div>
   </div>
 </div>