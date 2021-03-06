<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

i.fa-chevron-left {
	color: rgb(237, 237, 237);
	font-size: 500%;
}

i.fa-chevron-right {
	color: rgb(237, 237, 237);
	font-size: 500%;
}

.thumb{
	height: 230px;
	object-fit: cover;
}

/* i.fa-star-half-alt { */
/* 	color: rgb(255, 234, 0); */
/* } */

/* i.fa-star { */
/* 	color: rgb(255, 234, 0); */
/* } */

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 200%;
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

img.noResult {
	display: block;
	margin: 0px auto;
}

a {
	text-decoration: none;
}


#pop {
/* 	background: #e6e6e6; */
	background: #fff;
	border: 2px solid #eee;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 480px;
	height: auto;
	z-index: 10;
}

#imgPop {
	background: #e6e6e6;
	border: 1px solid #000;
	position: fixed;
	top: 15%;
	left: 25%;
	width: auto;
	height: auto;
	z-index: 10;
}

#imgPop #close {
	top: 10px;
	right: 10px;
	position: absolute;
	z-index: 9999;
}

#imgPop #prev {
	top: 50%;
	left: 10px;
	position: absolute;
	z-index: 9999;
	margin: 0;
	transform: translate(-50%, -50%)
}

#imgPop #next {
	top: 50%;
	right: -40px;
	position: absolute;
	z-index: 9999;
	margin: 0;
	transform: translate(-50%, -50%)
}

.mi_box {
	width: 60px;
	height: 60px;
	border-radius: 70%;
	overflow: hidden;
	cursor: pointer;
}

.ri_box {
	width: 80px;
	height: 80px;
	overflow: hidden;
	cursor: pointer;
}

.ri_box > img{
	width: 80px;	
	height: 80px; 
	object-fit: cover;
}

.si_box {
	width: 250px;
	height: 250px;
	overflow: hidden;
	cursor: pointer;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

.map_title {
	font-weight: bold;
	display: block;
}

.hAddr {
	position: absolute;
	left: 10px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 1;
	padding: 5px;
}

#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
</style>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	var shopId = '${shopId}';
	var logonId = '${logonId }';
	var s_category = '';
	var lat = '';
	var lng = '';

	$(document).ready(function() {
		$('#pop').hide();
		$('#imgPop').hide();
		$('div#close').click(function() {
			$('#imgPop').hide();
		})
		$('div#prev').click(function() {
			prev();
		})
		$('div#next').click(function() {
			next();
		})
		getUserLocation();
	})

	function openMemberPopup2(param) {
		let m_id = param + '';
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="
				+ m_id, "_blank",
				"resizable=no,top=0,left=0,width=450,height=500");
	}

	function prev() {
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if (idx != 0) {
			idx--;
			let path = '#' + m_id + '-split-' + idx + '-split-' + length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html(
					'<img src="'+src+'" id="'+id+'" width="720">');
		}
	}

	function next() {
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if (idx != length) {
			idx++;
			let path = '#' + m_id + '-split-' + idx + '-split-' + length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html(
					'<img src="'+src+'" id="'+id+'" width="720">');
		}
	}

	function printStar(score) {
		var calScore = score;
		var resultStar = '';
		while (true) {
			if (calScore >= 2) {
				resultStar += '<i class="fas fa-star text-warning"></i>';
				calScore -= 2;
				continue;
			} else if (calScore > 0) {
				resultStar += '<i class="fas fa-star-half-alt text-warning"></i>';
				break;
			} else {
				break;
			}
		}
		return resultStar;
	}

	function writeButton() {
		window.location.href = '${contextPath }/shop/writeShopReview.do?s_id='
				+ shopId;
	}

	function modifyButton() {
		window.location.href = '${contextPath }/shop/modifyShopReview.do?m_id='
				+ logonId + '&s_id=' + shopId;
	}

	function deleteButton() {
		var checkPop = confirm('정말로 소중한 리뷰를 삭제하시겠어요?');
		if (checkPop) {
			$
					.ajax({
						type : "post",
						async : true,
						url : "/andOne/shop/deleteShopReview.do",
						dataType : "text",
						data : 'm_id=' + logonId + '&s_id=' + shopId,
						success : function(data, textStatus) {
							alert('리뷰 삭제가 완료되었습니다.')
						},
						error : function(data, textStatus) {
							alert("에러가 발생했습니다.");
						},
						complete : function(data, textStatus) {
							window.location.href = '${contextPath }/shop/localShopDetail.do?s_id='
									+ shopId;
						}
					})
		}
	}

	function popup(p1, p2) {
		$('#pop').show();
		$
				.ajax({
					type : "post",
					async : true,
					url : "/andOne/shop/shopReviewPopup.do",
					dataType : "text",
					beforeSend : function(data, textStatus) {
						$('#popContent')
								.html(
										"<br><br><br><br><img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
					},
					data : "m_id=" + p1 + "&s_id=" + p2,
					success : function(data, textStatus) {
						var jsonStr = data;
						var jsonInfo = JSON.parse(jsonStr);
						var output = "<div class='row mx-2 mt-3'>";
						output += '<div class="mi_box">';
						if (jsonInfo.m_encodedImg == null) {
							output += '<img src="${contextPath }/resources/image/user.png" class="card-img-top" alt="...">';
						} else {
							output += '<img src="data:image/jpg;base64,'+jsonInfo.m_encodedImg+'" class="card-img-top" alt="...">';
						}
						output += '</div><div class="ml-3"><h4 class="mb-0">';
						output +=  jsonInfo.m_nickname + '</h4><small class="text-muted"><i class="fas fa-pencil-alt"></i>&nbsp;'+jsonInfo.sr_count+'</small></div>';
// 						output += '<span id="close" class="ml-auto h1" style="margin-top:-5px">&times;</span></div>';
						output += '</div><hr class="m-2"><div class="clearfix mx-3">';
						output += '<p class="float-left">'+printStar(jsonInfo.sr_score)+'</p>';
						output += '<p class="float-right">'+jsonInfo.sr_date+'</p></div>';
						output += '<div class="mx-3" style="height:280px;overflow:auto">'+jsonInfo.sr_content+'</div>';
// 						output += '<td rowspan="2"></td>'
// 						output += '<td rowspan="2" align="center" height="110">';
						output += '<div class="row mx-3">';
						for (let j = 0; j < Object
								.keys(jsonInfo.shopReviewImage).length; j++) {
							output += '<div style="margin: 5px">';
							output += '<div class="ri_box">';
							output += '<img src="data:image/jpg;base64,'
									+ jsonInfo.shopReviewImage[j].ri_encodedImg
									+ '" id="'
									+ jsonInfo.m_id
									+ '-split-'
									+ j
									+ '-split-'
									+ (Object.keys(jsonInfo.shopReviewImage).length - 1)
									+ '" class="card-img-top clickImg" alt="...">';
							output += '</div></div>';
						}
						// 				for(let j=0; j<3 - Object.keys(jsonInfo.shopReviewImage).length; j++){
						// 					output += 		'<div style="margin: 5px">';
						// 					output += 			'<div class="card" style="width: 5rem;">';
						// 					output += 				'<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
						// 					output += 			'</div></div>';
						// 				}
						output += '</div>'
// 						output += '</td>';
						if (logonId == p1) {
							output += '<div class="text-right mx-3">';
							output += '<button class="btn btn-primary btn-sm mr-1" onclick="modifyButton()">수정</button>';
// 							output += '</td>';
// 							output += '</tr>';
// 							output += '<tr>';
// 							output += '<td align="center">';
							output += '<button class="btn btn-danger btn-sm" onclick="deleteButton()">삭제</button>';
// 							output += '</td>';
							output += '</div>';
						} else {
// 							output += '<td></td></tr><tr><td></td></tr>'
						}
						$('#popContent').html(output);
						$('#close').click(function() {
							$('#pop').hide();
						})
					},
					error : function(data, textStatus) {
						alert("에러가 발생했습니다.");
					},
					complete : function(data, textStatus) {
						$('img.clickImg').click(
								function() {
									$('#imgPopContent').html(
											'<img src="' + (this.src)
													+ '" id="' + (this.id)
													+ '" width="720">');
									$('#imgPop').show();
								})
					}
				});
	}

	function getUserLocation() {
		$.ajax({
			type : "post",
			async : true,
			url : "/andOne/member/selectLocate.do",
			dataType : "text",
			success : function(data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				console.log(jsonInfo.M_LOCATE_LAT);
				lat = jsonInfo.M_LOCATE_LAT;
				console.log(jsonInfo.M_LOCATE_LNG);
				lng = jsonInfo.M_LOCATE_LNG;
				if (lat == 0 && lng == 0) {
					lat = '37.57045622903788';
					lng = '126.98529300126489';
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete : function(data, textStatus) {
				getShopDetail();
			}
		});
	}

	function getShopDetail() {
		$
				.ajax({
					type : "post",
					async : true,
					url : "/andOne/shop/getShopDetailByAjax.do",
					dataType : "text",
					beforeSend : function(data, textStatus) {
						$('div.recommendShop')
								.html(
										"<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
					},
					data : "s_id=" + shopId,
					success : function(data, textStatus) {
						var jsonStr = data;
						var jsonInfo = JSON.parse(jsonStr);
						var shopImage = "";
						var shopInformation = "";
						var reviewList = "";
						var recommendShop = "";

						var imageCount = Object.keys(jsonInfo.shopImage).length;
						var reviewCount = Object.keys(jsonInfo.shopReviewList).length;

						s_category = jsonInfo.s_category;
						console.log('======> 가게 카테고리');
						console.log(s_category);
						console.log('======> 가게 이름');
						console.log(jsonInfo.s_name);
						console.log('======> 리뷰 갯수');
						console.log(reviewCount);
						console.log('======> 가게 이미지 갯수');
						console.log(imageCount);
						shopImage += '<div class="row">';
						for (let i = 0; i < imageCount; i++) {
							shopImage += '<div style="margin: 15px">';
							shopImage += '<div class="si_box" style="width: 20rem;">';
							shopImage += '<img src="data:image/jpg;base64,'
									+ jsonInfo.shopImage[i].si_encodedImg
									+ '"id="'
									+ jsonInfo.s_id
									+ '-split-'
									+ i
									+ '-split-'
									+ (Object.keys(jsonInfo.shopImage).length - 1)
									+ '" class="card-img-top clickImg img-thumbnail" alt="...">';
							shopImage += '</div></div>';
						}
						// 				for(let i=0; i<3-imageCount; i++){
						// 					shopImage += '<div style="margin: 15px">';
						// 					shopImage += '<div class="card" style="width: 20rem;">';
						// 					shopImage += '<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
						// 					shopImage += '</div></div>';
						// 				}
						shopImage += '</div>';

						shopInformation += '<table><tr><td width="600">';
						shopInformation += '<h1>' + jsonInfo.s_name
								+ '</h1></td><td width="350"></td>';
						shopInformation += '<td align="right" width="170">';
						shopInformation += '<button id="all" type="button" class="btn btn-outline-primary" onclick="writeButton()">리뷰 쓰기</button>';
						shopInformation += '</td></tr>';
						shopInformation += '<tr><td><a href="${contextPath }/shop/localShopSearch.do?filter='
								+ jsonInfo.s_category
								+ '">'
								+ '<p class="h4 text-muted">'+jsonInfo.gc_name+'</p>'
								+ '</a></td>';
						//지도
						shopInformation += '<td align="left" colspan="2" rowspan="4"><div class="map_wrap"><div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div><div class="hAddr"><span class="map_title">업체 상세 주소</span> <span id="centerAddr"></span></div></div></td></tr>';
						shopInformation += '<tr><td><p>'
								+ printStar(jsonInfo.s_score) + '</p></td></tr>';
						shopInformation += '<tr><td>';
						var hashtagArr = jsonInfo.s_hashtag.split(',');
						for (let i = 0; i < hashtagArr.length; i++) {
							shopInformation += '<a class="btn btn-sm btn-light" href="${contextPath }/shop/localShopSearch.do?searchCondition=SEARCHBYHASHTAG&searchKeyword='
									+ hashtagArr[i]
									+ '">#'
									+ hashtagArr[i]
									+ '</a>&nbsp;';
						}
						shopInformation += '</td></tr><tr>';
						shopInformation += '<td valign="top" height="300"><div class="mt-3">'
								+ jsonInfo.s_content + '</div></td>';
						shopInformation += '</tr></table>';

						reviewList += '<hr><h3><a class="text-dark" href="${contextPath }/shop/getShopReviewList.do?s_id='
								+ shopId
								+ '">후기('
								+ jsonInfo.reviewCount
								+ ')</a></h3>';
						for (let i = 0; i < reviewCount; i++) {
							reviewList += '<table><tr><td rowspan="3" width="80" valign="top">';
							reviewList += '<div style="margin: 10px">';
							reviewList += '<div class="mi_box" >';
							reviewList += '<a href="javascript:void(0);" onclick="openMemberPopup2(\''
									+ jsonInfo.shopReviewList[i].m_id + '\')">';
							if (jsonInfo.shopReviewList[i].m_encodedImg == null) {
								reviewList += '<img src="${contextPath }/resources/image/user.png" class="card-img-top" alt="...">';
							} else {
								reviewList += '<img src="data:image/jpg;base64,'+jsonInfo.shopReviewList[i].m_encodedImg+'" class="card-img-top" alt="...">';
							}
							reviewList += '</a></div></div></td>';
							reviewList += '<td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'" width="680"><b>'
									+ jsonInfo.shopReviewList[i].m_nickname + '</b></td>';
							for (let j = 0; j < 3 - Object
									.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++) {
								reviewList += '<td rowspan="3" width="80">';
								reviewList += '<div style="margin: 5px">';
								reviewList += '<div style="width: 5rem;">';
								reviewList += '<img src="${contextPath}/resources/image/nbsp_img.png" class="card-img-top" alt="...">';
								reviewList += '</div></div>';
								reviewList += '</td>';
							}
							for (let j = 0; j < Object
									.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++) {
								reviewList += '<td rowspan="3" width="80">';
								reviewList += '<div style="margin: 5px">';
								reviewList += '<div class="ri_box">';
								reviewList += '<img src="data:image/jpg;base64,'
										+ jsonInfo.shopReviewList[i].shopReviewImage[j].ri_encodedImg
										+ '" id="'
										+ jsonInfo.shopReviewList[i].m_id
										+ '-split-'
										+ j
										+ '-split-'
										+ (Object
												.keys(jsonInfo.shopReviewList[i].shopReviewImage).length - 1)
										+ '" class="card-img-top clickImg img-thumbnail" alt="...">';
								reviewList += '</div></div>';
								reviewList += '</td>';
							}
							reviewList += '</tr><tr><td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'" width="80">'
									+ printStar(jsonInfo.shopReviewList[i].sr_score)
									+ '</td></tr>';
							reviewList += '<tr><td class="clickArea" id="'+jsonInfo.shopReviewList[i].m_id+'" value="rl" width="80">'
									+ jsonInfo.shopReviewList[i].sr_content
									+ '</td>';
							reviewList += '<td width="100" align="right" class="text-muted">'
									+ jsonInfo.shopReviewList[i].sr_date
									+ '</td></tr></table><hr>';
						}
						recommendShop += '<h3 class="mt-4">업체추천</h3><div id="recommendShopList"></div>'

						$('div.shopImage').html(shopImage);
						$('div.shopInformation').html(shopInformation);
						$('div.reviewList').html(reviewList);
						$('div.recommendShop').html(recommendShop);
						$('td.clickArea').click(function() {
							let m_id = $(this).attr('id');
							popup(m_id, shopId);
						})
						//지도생성
						//위도, 경도
						var x = jsonInfo.s_locate_lat;
						var y = jsonInfo.s_locate_lng;
						console.log(x);
						console.log(y);
						//지도 그리기
						var container = document.getElementById('map');
						var options = {
							center : new kakao.maps.LatLng(x, y),
							level : 3
						};
						var map = new kakao.maps.Map(container, options);
						//마커 생성
						var markerPosition = new kakao.maps.LatLng(x, y);
						var marker = new kakao.maps.Marker({
							position : markerPosition
						});
						marker.setMap(map);
						//좌표로 주소 받아오기
						var geocoder = new kakao.maps.services.Geocoder();
						var coord = new kakao.maps.LatLng(x, y);
						var callback = function(result, status) {
							if (status === kakao.maps.services.Status.OK) {
								console.log('그런 너를 마주칠까 '
										+ result[0].address.address_name
										+ '을 못가');
								var infoDiv = document
										.getElementById('centerAddr');
								infoDiv.innerHTML = result[0].address.address_name;
							}
						};
						geocoder.coord2Address(coord.getLng(), coord.getLat(),
								callback);
						//인포윈도우
						var linkPath = 'https://map.kakao.com/link/to/'+jsonInfo.s_name+','+jsonInfo.s_locate_lat+','+jsonInfo.s_locate_lng;
						var iwContent = '<div style="padding:5px;"><a target="_blank" href="'+linkPath+'">'+jsonInfo.s_name+'</a></div>';
						var iwPosition = new kakao.maps.LatLng(x, y);
						var infowindow = new kakao.maps.InfoWindow({
							position : iwPosition,
							content : iwContent
						});
						infowindow.open(map, marker);
					},
					error : function(data, textStatus) {
						alert("에러가 발생했습니다.");
					},
					complete : function(data, textStatus) {
						$('img.clickImg').click(
								function() {
									console.log(this.id);
									$('#imgPopContent').html(
											'<img src="' + (this.src)
													+ '" id="' + (this.id)
													+ '" width="720">');
									$('#imgPop').show();
								})
						recommend();
					}
				});
	}

	function recommend() {
		$.ajax({
					type : "post",
					async : true,
					url : "${contextPath}/shop/searchByAjax.do",
					dataType : "text",
					beforeSend : function(data, textStatus) {
						$('div#recommendShopList')
								.html(
										"<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
					},
					data : "M_LOCATE_LAT=" + lat + "&M_LOCATE_LNG=" + lng
							+ "&limit=30&filter=" + s_category
							+ "&searchCondition=GETRECOMMENDLIST&s_id="
							+ shopId,
					success : function(data, textStatus) {
						console.log('======>추천 아작스');
						console.log(s_category);
						var jsonStr = data;
						var jsonInfo = JSON.parse(jsonStr);
						var shopCount = Object.keys(jsonInfo.resultList).length;
						var output = "";
						if (shopCount == 0) {
							output += "<h3>추천 가게가 없습니다.</h3>";
						} else {
							if (shopCount > 3) {
								shopCount = 3;
							}
							output += "<div class='mt-4 row mx-1'>";
							for (let i = 0; i < shopCount; i++) {
								console.log(jsonInfo.resultList[i].s_name);
								output += "<div class='col-3 px-1 d-inline-block align-top'>";
								output += "<div class='card mx-1'>";
								output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="
										+ jsonInfo.resultList[i].s_id + "'>";
								if (Object
										.keys(jsonInfo.resultList[i].shopImage).length != 0) {
									output += "<img src='data:image/jpg;base64,"+jsonInfo.resultList[i].shopImage[0].si_encodedImg+"' class='card-img-top thumb'alt='...'>";
								} else {
									output += "<img src='${contextPath }/resources/image/ina.png' class='card-img-top thumb'alt='...'>";
								}
								output += "</a>";
// 								output += "</div>";
								output += "<div class='card-body'><small class='text-secondary'>"+jsonInfo.resultList[i].gc_name+"</small>";
								output += "<h4 class='card-title'><a href='${contextPath}/shop/localShopDetail.do?s_id="
										+ jsonInfo.resultList[i].s_id
										+ "'>"
										+ jsonInfo.resultList[i].s_name
										+ "</a></h4>";
								output += "<div id='recommendAddr"+i+"'></div>";
								output += "<p class='text-right mt-2 mb-0'><i class='fas fa-map-marker-alt mr-1 text-muted'></i>";
								if (jsonInfo.resultList[i].distance < 1) {
									output += (jsonInfo.resultList[i].distance * 1000)
											+ "m";
								} else {
									output += jsonInfo.resultList[i].distance
											+ "km";
								}
								output += "</p></div>";
								output += "<div class='card-body border-top clearfix' id='review'>";
								output += "<p class='mb-0 card-text float-left'>";
								output += "<a href='#'>후기 "
										+ jsonInfo.resultList[i].reviewCount
										+ "건</a></p>";
								output += "<p class='mb-0 card-text float-right'>"
										+ printStar(jsonInfo.resultList[i].s_score)
										+ "</p></div></div></div>";
							}
							output += "</div></div>";
						}
						$('div#recommendShopList').html(output);
						//위치정보 입력
						for (let i = 0; i < shopCount; i++) {
							//위도, 경도
							var x = jsonInfo.resultList[i].s_locate_lat;
							var y = jsonInfo.resultList[i].s_locate_lng;
							//좌표로 주소 받아오기
							var geocoder = new kakao.maps.services.Geocoder();
							var coord = new kakao.maps.LatLng(x, y);
							var callback = function(result, status) {
								if (status === kakao.maps.services.Status.OK) {
									console.log('그런 너를 마주칠까 '
											+ result[0].address_name + '을 못가');
									var infoDiv = document
											.getElementById('recommendAddr' + i);
									infoDiv.innerHTML = "<p class='card-text'>"
											+ result[0].address_name + "</p>"
								}
							};
							geocoder.coord2RegionCode(coord.getLng(), coord
									.getLat(), callback);
						}
					},
					error : function(data, textStatus) {
						alert("에러가 발생했습니다.");
					},
					complete : function(data, textStatus) {
					}
				});
	}
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div class="container my-5 center">
		<div class="shopImage"></div>

		<div class="shopInformation"></div>


		<div class="reviewList"></div>



		<div class="recommendShop"></div>
	</div>
	<br>
	<div id='pop' class="p-3">
		<span id="close" class="h1 float-right">&times;</span>
		<div id='popContent'  style="height: 530px;"></div>
	</div>

	<div id='imgPop'>
		<div id='close'>
			<img width='30' height='30'
				src='${contextPath }/resources/image/close2.png'>
		</div>
		<div id='imgPopContent' style="width: auto;"></div>
		<div id='prev'>
			<i class="fas fa-chevron-left"></i>
		</div>
		<div id='next'>
			<i class="fas fa-chevron-right"></i>
		</div>
	</div>
</body>

</html>