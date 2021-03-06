/**
 * 
 */
$(document).ready(function(){
	// 멤버디테일 조회
	$(".searchCommonMemberDetail").click(function(){
		console.log("디테일조회!");
		$("#popup-container").toggle();
		var tdArr = new Array();
		var checkBtn = $(this);
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var userId = td.eq(0).text(); // 1->0 수정 (번호 바꿔서)
		console.log(userId);
		// ajax
				$.ajax({
					type: "get",
					dataType: "text",
					async: true,
					url: "/andOne/popup.do",
					data: { m_id: userId },
					success: function (data, texStatus) {
						jsoninfo = JSON.parse(data);
						$('td.id').html(jsoninfo.m_id);
						$('td.phone').html(jsoninfo.m_phonenumber);
						$('td.email').html(jsoninfo.m_email);
						$('td.gender').html(jsoninfo.m_gender);
						$('td.nickname').html(jsoninfo.m_nickname);
						$('td.age').html(jsoninfo.m_age + "대");
						$('td.m_score').html(jsoninfo.m_score);
						$('td.reportCnt').html(jsoninfo.reportCnt);
						if (jsoninfo.p_currentpoint != null) {
							$('td.p_currentpoint').html(jsoninfo.p_currentpoint);
						} else {
							$('td.p_currentpoint').html("0");
						}
						$('td.qnaCnt').html(jsoninfo.qnaCnt);
						$('td.joinClubCnt').html(jsoninfo.joinClubCnt);
						$('td.reviewCnt').html(jsoninfo.reviewCnt);
						$('.resultList').remove();
						if (jsoninfo.list != "") {
							for (var i in jsoninfo.list) {
								$('table.pointList').append("<tr class='resultList'><td style='text-align:center;width:20%'>" + jsoninfo.list[i].p_id + "<td style='text-align:center;width:30%'>" + jsoninfo.list[i].p_date + "</td><td style='text-align:center;width:30%'>" + jsoninfo.list[i].p_detail + "</td><td style='text-align:center;width:20%'>" + jsoninfo.list[i].p_changepoint + "</td></tr>");
							}
						} else {
							$('table.pointList').append("<p class='resultList'>포인트이력이 없습니다</p>");
						}
					}
				});
		
	});
	
	$(".searchDetail").click(function(){	// QNA
		$("#popup-container").toggle();
		// ajax
		let _q_id = (event.target).parentNode.parentNode.getAttribute("id");
		$.ajax({
            type: "post",
            async: "true",
            dataType: "json",
            data: {
                q_id: _q_id //data로 넘겨주기
            },
            url: "popupQnADetail.do",
            success: function (data, textStatus) {
            	$("#detail_q_id").html(data.q_id);
            	$("#detail_q_type").html(data.q_type);
            	$("#detail_q_state").html(data.q_state);
            	$("#detail_m_id").html(data.m_id);
            	$("#detail_q_subject").html(data.q_subject);
            	$("#detail_q_content").html(data.q_content);
            	$("#detail_q_date").html(data.q_date);
				CKEDITOR.instances.detail_q_reply.setData(data.q_reply);
//            	$("#detail_q_reply").val(data.q_reply);
            }
		});
	});

	$(".searchReportDetail").click(function(){	// 신고하기
		$("#popup-container").toggle();
		// ajax
		let _r_id = (event.target).parentNode.parentNode.getAttribute("id");
		$.ajax({
            type: "post",
            async: "true",
            dataType: "json",
            data: {
                r_id: _r_id //data로 넘겨주기
            },
            url: "popupReportDetail.do",
            success: function (data, textStatus) {
            	$("#detail_r_id").html(data.r_id);
            	$("#detail_r_type").html(data.r_type);
            	$("#detail_r_category").html(data.r_category);
            	$("#detail_r_target").html(data.r_target);
            	$("#detail_r_state").html(data.r_state);
            	$("#detail_m_id").html(data.m_id);
            	$("#detail_r_subject").html(data.r_subject);
            	$("#detail_r_content").html(data.r_content);
            	$("#detail_r_date").html(data.r_date);
				CKEDITOR.instances.detail_r_reply.setData(data.r_reply);
//            	$("#detail_q_reply").val(data.q_reply);
            }
		});
	});
	
	$("#popup-close").click(function(){
		$("#popup-container").toggle();
	});
	
	//상태변경 report
	$("#editReportState").click(function(){
		// ajax
		let _r_id = $("#detail_r_id").text();
		let _r_state = $("#edit_r_state").val();
		let _m_id = $("#detail_m_id").text();
		$.ajax({
            type: "post",
            async: "true",
            dataType: "text",
            data: {
                //data로 넘겨주기
                r_id: _r_id,
                r_state: _r_state
            },
            url: "saveReportState.do",
            success: function (data, textStatus) {
				alert("변경완료");
				// 알림
				let type = '70';
				let target = _m_id;
				let content = '['+_r_id+'] 신고내역의 상태가 변경되었습니다.' ;
				let url = '/andOne/member/searchReport.do';
				// db저장	
				$.ajax({
					type: 'post',
					url: '/andOne/member/saveNotify.do',
					dataType: 'text',
					data: {
						target: target,
						content: content,
						type: type,
						url: url
					},
					success: function(){
						socket.send("관리자,"+target+","+content+","+url);	// 소켓에 전달
					}
				});
            	location.reload();	// 새로고침
            }
		});
	});

	//상태변경 QNA
	$("#editState").click(function(){
		// ajax
		let _q_id = $("#detail_q_id").text();
		let _q_state = $("#edit_q_state").val();
		let _m_id = $("#detail_m_id").text();
		$.ajax({
            type: "post",
            async: "true",
            dataType: "text",
            data: {
                //data로 넘겨주기
                q_id: _q_id,
                q_state: _q_state
            },
            url: "saveQnAState.do",
            success: function (data, textStatus) {
				alert("변경완료");
				// 알림
				let type = '70';
				let target = _m_id;
				let content = '['+_q_id+'] 문의사항 상태가 변경되었습니다.' ;
				let url = '/andOne/member/searchQnA.do';
				// db저장	
				$.ajax({
					type: 'post',
					url: '/andOne/member/saveNotify.do',
					dataType: 'text',
					data: {
						target: target,
						content: content,
						type: type,
						url: url
					},
					success: function(){
						socket.send("관리자,"+target+","+content+","+url);	// 소켓에 전달
					}
				});
            	location.reload();	// 새로고침
            }
		});
	});

	//답변작성 Report
	$("#saveReportReply").click(function(){
		// ajax
		let _r_id = $("#detail_r_id").text();
		let _r_reply =	CKEDITOR.instances.detail_r_reply.getData();
		let _m_id = $("#detail_m_id").text();
		$.ajax({
			type: "post",
			async: "true",
			dataType: "text",
			data: {
				//data로 넘겨주기
				r_id: _r_id,
				r_reply: _r_reply
			},
			url: "saveReportState.do",
			success: function (data, textStatus) {
				// 알림
				let type = '70';
				let target = _m_id;
				let content = '['+_r_id+'] 신고내역 답변이 등록되었습니다.' ;
				let url = '/andOne/member/searchReport.do';
				// db저장	
				$.ajax({
					type: 'post',
					url: '/andOne/member/saveNotify.do',
					dataType: 'text',
					data: {
						target: target,
						content: content,
						type: type,
						url: url
					},
					success: function(){
						socket.send("관리자,"+target+","+content+","+url);	// 소켓에 전달
					}
				});
			}
		});
	});
	
	//답변작성 Qna
	$("#saveReply").click(function(){
		// ajax
		let _q_id = $("#detail_q_id").text();
		let _q_reply =	CKEDITOR.instances.detail_q_reply.getData();
		let _m_id = $("#detail_m_id").text();
		$.ajax({
			type: "post",
			async: "true",
			dataType: "text",
			data: {
				//data로 넘겨주기
				q_id: _q_id,
				q_reply: _q_reply
			},
			url: "sendReplyQnA.do",
			success: function (data, textStatus) {
				// 알림
				let type = '70';
				let target = _m_id;
				let content = '['+_q_id+'] 문의사항 답변이 등록되었습니다.' ;
				let url = '/andOne/member/searchQnA.do';
				// db저장	
				$.ajax({
					type: 'post',
					url: '/andOne/member/saveNotify.do',
					dataType: 'text',
					data: {
						target: target,
						content: content,
						type: type,
						url: url
					},
					success: function(){
						socket.send("관리자,"+target+","+content+","+url);	// 소켓에 전달
					}
				});
			}
		});
	});

});
