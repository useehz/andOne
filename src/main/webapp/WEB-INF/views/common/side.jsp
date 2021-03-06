<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<body>
	<ul>
		<li>나의 정보</li>
		<ul class="mb-3">
			<a href="${contextPath}/and/wroteAndOne.do"><li>내가 쓴 &분의일</li></a>
			<a href="${contextPath}/and/participateAndOne.do"><li>내가 참가한 &분의일</li></a>
			<a href="#"><li>최근조회한 &분의일</li></a>
			<a href="${contextPath}/shop/getShopReviewList.do"><li>내 지역업체 리뷰</li></a>
			<a href="${contextPath}/member/score.do"><li>내 매너점수</li></a>
			<a href="${contextPath}/member/wroteReview.do"><li>내가 쓴 회원평가</li></a>
			<a href="${contextPath}/member/receivedReview.do"><li>내가 받은 회원평가</li></a>
			<a href="${contextPath}/member/updateMember.do"><li>내 정보 변경</li></a>
			<a href="${contextPath}/member/deleteMember.do"><li>회원탈퇴</li></a>
		</ul>
		<li>포인트 관리</li>
		<ul class="mb-3">
			<a href="${contextPath}/point/charge.do"><li>포인트 충전</li></a>
			<a href="${contextPath}/point/pointDetail.do"><li>포인트 사용이력</li></a>
			<a href="${contextPath}/point/exchange.do"><li>포인트 환전</li></a>
		</ul>
		<li>서비스 문의/신고</li>
		<ul class="mb-3">
			<a href="${contextPath}/member/qna.do"><li>1:1 문의</li></a>
			<a href="${contextPath}/member/searchQnA.do"><li>문의 내역</li></a>
			<a href="${contextPath}/member/searchReport.do"><li>신고 내역</li></a>
		</ul>
	</ul>
</body>
</html>