<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<title>헤더</title>
<style>
	.box {
	    width: 50px;
	    height: 50px; 
	    border-radius: 70%;
	    overflow: hidden;
	    cursor: pointer;
	}
	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	div#memberLayer{
		width: 250px;
		margin-left: -250px;
		margin-top: 20px;
		position: absolute;
 		visibility: hidden; 
		z-index:9999;
	}
	div#memberLayer a{
		text-decoration: none;
	}
	#memberLayer p.point::before{
		font-family: "Font Awesome 5 Free"; font-weight: 900; content: "\f51e";
		margin-right: 0.5em;
		color: #ffc107;
	}
	#memberLayer h5.card-title::before{
		font-family: "Font Awesome 5 Free"; font-weight: 900; content: "\f007";
		margin-right: 0.5em;
		color:gray;
	}
	
	#msgStack{
		width: 280px;
		right: 10px;
		bottom: 10px;
		position: fixed;
		z-index: 9999;
	}
	
	.toast{
		cursor: pointer;
	}
	
	.badge{
		font-size: 10px;
    	height: 15px;
    	margin-left: -24px;
	}
</style>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	// 웹소켓 연결
	var socket  = null;

	// comma 
	function pointToNumFormat(num) {
    	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function onProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.add("visible");
	}
	function outProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.remove("visible");
	}
	
	// 프로필 클릭 
	function openMemberPopup(){
			var popupOpener;
			let m_id = '${m_id}';
			popupOpener = window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	$(document).ready(function(){
		 sock = new SockJS("<c:url value="/echo-ws"/>");
		 socket = sock;

		// 데이터를 전달 받았을때 
		sock.onmessage = onMessage;
		
		// 데이터를 보냈을 때
		
    	// 세션에서 이미지 읽기
		var profileImg = '${profileImg}';
       	if(profileImg==null || profileImg==""){	
       		$(".profile").attr("src","${contextPath}/resources/image/user.png")
       	}else{	// null이 아닐경우
       		$(".profile").attr("src","data:image/png;base64, "+profileImg);
       	}
       	
       	// 포인트 읽기
   		$.ajax({
               type: "post",
               async: "true",
               dataType: "text",
               data: {
                   m_id: '${m_id}' //data로 넘겨주기
               },
               url: "${contextPath}/point/selectNowPoint.do",
               success: function (data, textStatus) {
            	   if(data!=''){
		       			$("#point").text(pointToNumFormat(data));
            	   }else{
            		   $("#point").text(0);
            	   }
               }
		});
       	
       	// 알림 카운트 받아오기
   		$.ajax({
               type: "post",
               async: "true",
               dataType: "text",
               data: {
                   m_id: '${m_id}' //data로 넘겨주기
               },
               url: "${contextPath}/member/selectNewNoticeCnt.do",
               success: function (data, textStatus) {
            	   if(data!='0'){
		       			$("#newNoticeCnt").text(data);
            	   }
               }
		});

       	
       	
	});
   	
   	// 실시간 알림 받았을 시
	function onMessage(evt){
		var data = evt.data;
		// toast
		let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
		toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
		toast += "<small class='text-muted'></small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
		toast += "<span aria-hidden='true'>&times;</span></button>";
		toast += "</div> <div class='toast-body'>" + data + "</div></div>";
		$("#msgStack").append(toast);
		$(".toast").toast({"animation": true, "autohide": false});
// 		$(".toast").toast({"animation": true, "autohide": true, "delay": 5000});
		$('.toast').toast('show');
		// 알림 카운트 추가
		$("#newNoticeCnt").text($("#newNoticeCnt").text()*1+1);
	};	
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand logotype ml-3 text-primary" href="${contextPath}/"><spring:message code="title" /></a>
	 <spring:message code="header.subTitle" />
	 
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNavDropdown">
	    <ul class="navbar-nav ml-auto mr-2">
   	      <li class="nav-item dropdown h5">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          <spring:message code="title" />
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
	         	<a class="dropdown-item" href="${contextPath}/andeat?g_id=010"><spring:message code="andEat" /></a>
          		<a class="dropdown-item" href="${contextPath}/andeat?g_id=011"><spring:message code="andBuy" /></a>
         		<a class="dropdown-item" href="${contextPath}/andeat?g_id=012"><spring:message code="andDo" /></a>
	        </div>
	      </li>
<!-- 	      <li class="nav-item h5"> -->
<!-- 	        <a class="nav-link" href="#">찾기</a> -->
<!-- 	      </li> -->
	      <li class="nav-item h5">
	        <a class="nav-link" href="${contextPath}/club/clubMain.do"><spring:message code="menu.club" /></a>
	      </li>
	      <li class="nav-item h5">
	        <a class="nav-link" href="${contextPath}/shop/localShopMain.do"><spring:message code="menu.shop" /></a>
	      </li>
       <c:choose>
          <c:when test="${isLogOn == true && m_id!= null}">
          	<li class="nav-item h3">
			      	<a class="nav-link py-0" href="${contextPath}/message/messageInit.do"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chat-text " fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  		<path fill-rule="evenodd" d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"></path>
		  		<path fill-rule="evenodd" d="M4 5.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8zm0 2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5z"></path>
			</svg></a></li>
      		<li class="nav-item h3">
	       		<a class="nav-link py-0" href="${contextPath}/member/notify.do"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bell" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2z"/>
				  <path fill-rule="evenodd" d="M8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
				</svg></a>
	      	</li>
	      	<span id="newNoticeCnt" class="badge badge-pill badge-primary"></span>
	      	</ul>
          	<!-- 프로필사진 -->
          	<div class="box" style="background: #BDBDBD;" onmouseover="onProfile()" onmouseout="outProfile()" onClick="openMemberPopup()">
    			<img class="profile">
			</div>
			<div class="ml-3">
				<div id="memberLayer" class="card" onmouseover="onProfile()" onmouseout="outProfile()">
					<div class="card-body">
			            <h5 class="card-title"><b>${m_nickname}</b>
			            	<a href="${contextPath}/member/updateMember.do"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
							  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
							</svg></a>
			            </h5>
						<div class="row mx-1">
							<p class="point mb-0"><span id="point" class="font-weight-bold"></span>point</p>
							<a href="${contextPath}/point/charge.do" class="btn btn-outline-primary btn-sm ml-auto"><spring:message code="menu.chargeBtn" /></a>
						</div>
					</div>
				<ul class="list-group list-group-horizontal">
					<li class="list-group-item col-6 text-center"><a href="${contextPath}/member/mypage.do"><spring:message code="menu.mypage" /></a></li>
		  			<li class="list-group-item col-6 text-center"><a href="${contextPath}/member/logout.do"><spring:message code="menu.logoutBtn" /></a></li>
				</ul>
			</div>
			
          </c:when>
          <c:otherwise>
          </ul>
		  	<a class="btn btn-outline-secondary btn-sm" style="margin-top:-6px" href="${contextPath}/member/login.do"><spring:message code="menu.loginBtn" /></a>
	      </c:otherwise>
	   </c:choose>     
	  </div>
	</nav>
    <div id="msgStack">
	</div>

</body>
</html>