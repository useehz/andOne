<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>

<head>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

i.fa-chevron-left{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-chevron-right{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-star-half-alt{
	color:rgb(255,234,0);
}

i.fa-star{
	color:rgb(255,234,0);
}

h5 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 150%;
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 200%;
}

h1 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 400%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

button#search {
	font-family: FontAwesome;
}

div.search {
	text-align: center;
}

.card {
	
}

img.noResult{
	display:block; margin:0px auto;
}

a {
	text-decoration: none;
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:active {
	color: black;
}

a:hover {
	color: black;
}

#pop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 20%;
	left: 25%;
	width: 480px;
	height: auto;
	z-index: 10;
}

#imgPop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 15%;
	left: 25%;
	width: auto;
	height: auto;
	z-index: 99;
}

#imgPop #close{
	top:10px;
	right: 10px;
	position: absolute;
	z-index:9999;
}

#imgPop #prev{
  	top: 50%;
	left: 10px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

#imgPop #next{
	top: 50%;
	right: -40px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

.mi_box {
	    width: 80px;
	    height: 80px; 
	    border-radius: 70%;
	    overflow: hidden;
	    cursor: pointer;
	    object-fit:cover;
	}
	
.ri_box {
	width: 80px;	
	height: 80px; 
    overflow: hidden;
    cursor: pointer;
	}
	
.si_box{
	width: 250px;
	height: 250px; 
    overflow: hidden;
    cursor: pointer;
	}	
	

</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	
	var logonId = '${logonId }';
	
	$(document).ready(function(){
		$('#imgPop').hide();
		$('div#close').click(function(){
			$('#imgPop').hide();
		})
		$('div#prev').click(function(){
			prev();
		})
		$('div#next').click(function(){
			next();
		})
		$('img.clickImg').click(function(){
			$('#imgPopContent').html('<img src="'+(this.src)+'" id="'+(this.id)+'" width="720">');
			$('#imgPop').show();
		})
		$('#pop').hide();
		$('td#close').click(function(){
			$('#pop').hide();
		})
		
		$('table .clickArea').click(function(){
			$('#pop').show();
			var id = $(this).attr("id");
			var nickname = $('table#'+id+' tr:nth-child(1) td:nth-child(2)').text();
			var score = $('table#'+id+' tr:nth-child(2) td:nth-child(1)').html();
			var date = $('table#'+id+' tr:nth-child(3) td:nth-child(2)').text();
			var content = $('table#'+id+' tr:nth-child(3) td:nth-child(1)').text();
			var profileSrc = $('table#'+id+' tr:nth-child(1) td:nth-child(1) img').attr("src");
			var imgSrc1 = $('table#'+id+' tr:nth-child(1) td:nth-child(3) img').attr("src");
			var imgId1 = $('table#'+id+' tr:nth-child(1) td:nth-child(3) img').attr("id");
			var imgSrc2 = $('table#'+id+' tr:nth-child(1) td:nth-child(4) img').attr("src");
			var imgId2 = $('table#'+id+' tr:nth-child(1) td:nth-child(4) img').attr("id");
			var imgSrc3 = $('table#'+id+' tr:nth-child(1) td:nth-child(5) img').attr("src");
			var imgId3 = $('table#'+id+' tr:nth-child(1) td:nth-child(5) img').attr("id");
			
			$('#pop table tr:nth-child(1) td:nth-child(1) img').attr("src",profileSrc);
			$('#pop table tr:nth-child(1) td:nth-child(2) h2').text(nickname);
			$('#pop table tr:nth-child(2) td:nth-child(1)').html(score);
			$('#pop table tr:nth-child(2) td:nth-child(2)').text(date);
			$('#pop table tr:nth-child(3) td:nth-child(1)').text(content);
			$('#pop table tr:nth-child(4) td:nth-child(2) img.1').attr("src",imgSrc1);
			$('#pop table tr:nth-child(4) td:nth-child(2) img.2').attr("src",imgSrc2);
			$('#pop table tr:nth-child(4) td:nth-child(2) img.3').attr("src",imgSrc3);
			if(isEmpty(imgId1)){
				$('#pop table tr:nth-child(4) td:nth-child(2) img.1').removeAttr("id");
			}else{
				$('#pop table tr:nth-child(4) td:nth-child(2) img.1').attr("class","card-img-top clickImg 1");
				$('#pop table tr:nth-child(4) td:nth-child(2) img.1').attr("id",imgId1);
			}
			if(isEmpty(imgId2)){
				$('#pop table tr:nth-child(4) td:nth-child(2) img.2').removeAttr("id");
			}else{
				$('#pop table tr:nth-child(4) td:nth-child(2) img.2').attr("class","card-img-top clickImg 2");
				$('#pop table tr:nth-child(4) td:nth-child(2) img.2').attr("id",imgId2);
			}
			if(isEmpty(imgId3)){
				$('#pop table tr:nth-child(4) td:nth-child(2) img.3').removeAttr("id");
			}else{
				$('#pop table tr:nth-child(4) td:nth-child(2) img.3').attr("class","card-img-top clickImg 3");
				$('#pop table tr:nth-child(4) td:nth-child(2) img.3').attr("id",imgId3);
			}
			if(!isEmpty(logonId) && logonId == id){
				$('#pop table tr:nth-child(4) td:nth-child(3)').html('<button class="btn btn-primary btn-sm" onclick="modifyButton()">수정</button>');
				$('#pop table tr:nth-child(5) td:nth-child(1)').html('<button class="btn btn-danger btn-sm" onclick="deleteButton()">삭제</button>');
			}else{
				$('#pop table tr:nth-child(4) td:nth-child(3)').html('');
				$('#pop table tr:nth-child(5) td:nth-child(1)').html('');
			}
			$('img.clickImg').click(function(){
				$('#imgPopContent').html('<img src="'+(this.src)+'" id="'+(this.id)+'" width="720">');
				$('#imgPop').show();
			})
		})
		
	})
	
	function openMemberPopup2(param){
		let m_id = param+'';
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	function writeButton(){
		window.location.href='${contextPath }/shop/writeShopReview.do?s_id=${s_id }';
	}
	
	function modifyButton(){
		window.location.href='${contextPath }/shop/modifyShopReview.do?m_id='+logonId+'&s_id=${s_id }'
	}
	
	function deleteButton(){
		var checkPop = confirm('정말로 소중한 리뷰를 삭제하시겠어요?');
		if(checkPop){
			$.ajax({
				type: "post",
				async: true,
				url: "/andOne/shop/deleteShopReview.do",
				dataType: "text",
				data: 'm_id='+logonId+'&s_id=${s_id }',
				success: function (data, textStatus) {
					alert('리뷰 삭제가 완료되었습니다.')
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) {
					window.location.href='${contextPath }/shop/getShopReviewList.do?s_id=${s_id }';
				}
			})
		}
	}
	
	function isEmpty(str){
		if(typeof str == "undefined" || str == null || str == ""){
			return true;
		}else{
			return false;
		}
	}
	
	function printStar(score){
		var calScore = score;
		var resultStar = '';
		while(true){
			if(calScore>=2){
				resultStar += '<i class="fas fa-star"></i>';
				calScore -= 2;
				continue;
			}else if(calScore>0){
				resultStar += '<i class="fas fa-star-half-alt"></i>';
				break;
			}else{
				break;
			}
		}
		return resultStar;
	}
	
	function prev(){
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if(idx != 0){
			idx--;
			let path = '#'+m_id+'-split-'+idx+'-split-'+length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html('<img src="'+src+'" id="'+id+'" width="720">');
		}
	}
	
	function next(){
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if(idx != length){
			idx++;
			let path = '#'+m_id+'-split-'+idx+'-split-'+length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html('<img src="'+src+'" id="'+id+'" width="720">');
		}
	}
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container my-5 center">
	<div>
	<h1>전체 리뷰 리스트</h1><br>
	<h5><a href="${contextPath }/shop/localShopDetail.do?s_id=${s_id }">가게정보 페이지로 돌아가기>></a></h5>
	<br><button id="all" type="button" class="btn btn-outline-info" onclick="writeButton()">리뷰 쓰기</button>
	<hr>
	<h3>후기(${reviewCount })</h3>
	</div>
	<div id="container">
		<c:forEach var="list" items="${reviewList }">
			<table id="${list.m_id }">
				<tr class="tr1">
					<td rowspan="3" width="80">
						<div style="margin: 10px">
							<div class="mi_box" style="width: 5rem;">
								<a href="javascript:void(0);" onclick="openMemberPopup2('${list.m_id }')">
									<c:choose>
										<c:when test="${empty list.m_encodedImg }">
											<img src="${contextPath }/resources/image/user.png" class="card-img-top" alt="...">
										</c:when>
										<c:otherwise>
											<img src="data:image/jpg;base64,${list.m_encodedImg }" class="card-img-top" alt="...">
										</c:otherwise>
									</c:choose>
								</a>
							</div>
						</div>
					</td>
					<td class="clickArea" id="${list.m_id }" width="680">
						${list.m_nickname }
					</td>
					<c:forEach var="i" begin="1" end="${3-(fn:length(list.shopReviewImage)) }">
						<td rowspan="3" width="80">
							<div style="margin:5px">
								<div style="width:5rem;">
									<img src="${contextPath}/resources/image/nbsp_img.png" class="card-img-top" alt="...">
								</div>
							</div>
						</td>
					</c:forEach>
					<c:forEach var="j" begin="1" end="${(fn:length(list.shopReviewImage)) }">
						<td rowspan="3" width="80">
							<div style="margin:5px">
								<div class="ri_box" style="width:5rem;">
									<img src="data:image/jpg;base64,${list.shopReviewImage[j-1].ri_encodedImg }" id="${list.m_id }-split-${j-1 }-split-${fn:length(list.shopReviewImage)-1 }" class="card-img-top clickImg img-thumbnail" alt="...">
								</div>
							</div>
						</td>
					</c:forEach>
				</tr>
				<tr class="tr2">
					<td class="clickArea" id="${list.m_id }" width="80">
						<c:choose>
							<c:when test="${list.sr_score eq 10}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 9}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 8}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 7}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 6}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 5}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 4}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 3}">
								<i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 2}">
								<i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 1}">
								<i class="fas fa-star-half-alt"></i>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr class="tr3">
					<td class="clickArea" id="${list.m_id }" width="80">
						${list.sr_content }
					</td>
					<td width="100">
						${list.sr_date }
					</td>
				</tr>	
			</table>
			<hr>
		</c:forEach>	
	</div>
	<!-- 페이징  -->
	<nav aria-label="Page navigation example">
	    <ul class="pagination justify-content-center">
	        <c:if test="${pagination.curRange ne 1 }">
	            <li class="page-item">
	            <a class="page-link" href="?curPage=1&s_id=${s_id}">처음</a> 
	            </li>
	        </c:if>
	        <c:if test="${pagination.curPage ne 1}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.prevPage}&s_id=${s_id}">이전</a> 
	                </li>
	        </c:if>
	        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
	            <c:choose>
	                <c:when test="${pageNum eq  pagination.curPage}">
	                    <li class="page-item active">
	                        <a class="page-link" href="?curPage=${pageNum}&s_id=${s_id}">${pageNum }</a>
	                    </li>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" href="?curPage=${pageNum}&s_id=${s_id}">${pageNum }</a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.nextPage}&s_id=${s_id}">다음</a> 
	                </li>	                        
	        </c:if>
	   	 </ul>
	</nav>
<!-- 페이징 END -->
	</div>
	<div id='imgPop'>
		<div id='close'><img width='30' height='30' src='${contextPath }/resources/image/close2.png'></div>
		<div id='imgPopContent' style="width:auto;">
		
		</div>
		<div id='prev'><i class="fas fa-chevron-left"></i></div>
		<div id='next'><i class="fas fa-chevron-right"></i></div>
	</div>
	
	<div id='pop'>
		<div id='popContent' style="height:530px;">
			<table>
			<tr>
			<td align="center" height="80" width="80">
			<div style="margin: 2px">
			<div class="card" style="width: 4rem;">
			<img src="" class="card-img-top" alt="...">
			</div>
			</div>
			</td>
			<td align="left" height="80" width="350"><h2>&nbsp;&nbsp;닉네임</h2></td>
			<td id="close" align="right" height="80" width="80" valign="top"><img src="${contextPath }/resources/image/close.png" height="40" width="40"></td>
			</tr>
			<tr>
			<td colspan="2" align="left" height="40">별점</td>
			<td align="right">날짜</td>
			</tr>
			<tr>
			<td colspan="2" height="300" valign="top">내용</td>
			<td></td>
			</tr>
			<tr>
			<td rowspan="2"></td>
			<td rowspan="2" align="center" height="110">
			<div class="row">
			<div style="margin: 5px">
			<div class="card" style="width: 5rem;">
			<img src="" class="card-img-top 1" alt="...">
			</div></div>
			<div style="margin: 5px">
			<div class="card" style="width: 5rem;">
			<img src="" class="card-img-top 2" alt="...">
			</div></div>
			<div style="margin: 5px">
			<div class="card" style="width: 5rem;">
			<img src="" class="card-img-top 3" alt="...">
			</div></div>
			</div>
			</td>
			<td align="center"></td>
			</tr>
			<tr>
			<td align="center"></td>
			</tr>
			</table>
		</div>
	</div>
</body>
</html>