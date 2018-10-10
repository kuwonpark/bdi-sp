<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>스프링테스트</title>
</head>
<script>
window.addEventListener('load',function(){
	var xhr = new XMLHttpRequest();
	xhr.open('GET','/board');
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4){
			if(xhr.status==200){
				var res = JSON.parse(xhr.responseText);
				var html = '';
				for(var bi of res){
					html += '<tr>'; 
					html += '<td>'+bi.binum+'</td>';
					html += '<td><input type="text" name="bititle'+bi.binum+'" value="'+bi.bititle+'"></td>';
					html += '<td><input type="text" name="bitext'+bi.bitext+'" value="'+bi.bitext+'"></td>';
					html += '<td><input type="text" name="bifile'+bi.bifile+'" value="'+bi.bifile+'"></td>';
					html += '<td>'+bi.bicredat+'</td>';
					html += '<td>'+bi.bimoddat+'</td>';
					html += '<td>'+bi.biactive+'</td>';
					html += '<td>'+bi.bicnt+'</td>';
					html += '<td>'+bi.uinum+'</td>';
					html += '<td><button onclick="boardUpdate('+bi.binum+')">수정</button>';
					html += ' <button onclick="boardDelete('+bi.binum+')">삭제</button></td>'; 
					html += '</tr>';
				}
				
				document.querySelector('#biBody').insertAdjacentHTML('beforeend',html);
			}else{
				
			}
		}
	}
	xhr.send();
});
</script>
<body>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글</th>
				<th>파일</th>
				<th>만든시간</th>
				<th>수정시간</th>
				<th>체크</th>
				<th>조회수</th>
				<th>유저번호</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody id="biBody">
		</tbody>
	</table>
	<button onclick="boardInfoAdd()">게시글추가</button>
	<script>
	function boardUpdate(binum){
		var bititle = document.querySelector('input[name=bititle'+binum+']').value;
		var bitext = document.querySelector('input[name=bitext'+binum+']').value;
		var bifile = document.querySelector('input[name=bifile'+binum+']').value;
		var param = {bititle:bititle,bitext:bitext,bifile:bifile};
		var xhr = new XMLHttpRequest();
		var url = "/board";
		xhr.open('PUT',url);
		xhr.setRequestHeader('Content-Type','application/json');
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					if(xhr.responseText=='1'){
						alert('수정성공');
						location.href='/uri/board/list';
					}	
				}else{
					alert('수정실패');
					}
				}
		}
		alert(JSON.stringify(param));
		xhr.send(JSON.stringify(param));
	}
	
	function boardDelete(binum){
		var xhr = new XMLHttpRequest();
		var url = "/board/" + binum;
		xhr.open('DELETE',url);
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					if(xhr.responseText=='1'){
						alert('삭제성공');
						location.href='uri//list';
					}	
				}else{
					alert('삭제실패');
					}
				}
		}
		xhr.send();
	}
	
	function boardInfoAdd(){
		var html = '<tr>';
			html += '<td>&nbsp;</td>';
			html += '<td><input type="text" name="bititle"></td>';
			html += '<td><input type="text" name="bitext"></td>';
			html += '<td>'+bicredat+'</td>';
			html += '<td>'+bimoddat+'</td>';
			html += '<td>'+biactive+'</td>';
			html += '<td>'+bicnt+'</td>';
			html += '<td>'+uinum+'</td>';
			html += '<td><button onclick="boardInsert()">저장</button></td>';
			html += '</tr>';
			document.querySelector('tbody').insertAdjacentHTML('beforeend',html);
	}
	
	function boardInsert(){
		var bititle = document.querySelector('input[name=bititle'+binum+']').value;
		var bitext = document.querySelector('input[name=bitext'+binum+']').value;
		var bifile = document.querySelector('input[name=bifile'+binum+']').value;
		var param = {bititle:bititle,bitext:bitext,bifile:bifile};
		var xhr = new XMLHttpRequest();
		var url = "/board";
		xhr.open('POST',url);
		xhr.setRequestHeader('Content-Type','application/json');
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4){
				if(xhr.status==200){
					if(xhr.responseText=='1'){
						alert('추가성공');
						location.href='/uri/board/list';
					}	
				}else{
					alert('추가실패');
					}
				}
		}
		alert(JSON.stringify(param));
		xhr.send(JSON.stringify(param));
	}
	
	</script>
</body>
</html>