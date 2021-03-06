<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/common/include/tags.jspf" %>
<jsp:scriptlet>
pageContext.setAttribute("crlf", "\r\n");
pageContext.setAttribute("lf", "\n");
pageContext.setAttribute("cr", "\r");
</jsp:scriptlet>
<link href="/resource/glider/code/css/shCore.css" rel="stylesheet" type="text/css" />
<link href="/resource/glider/code/css/shThemeDefault.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="/resource/libs/plugin/tip-yellow/tip-yellow.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-violet/tip-violet.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-darkgray/tip-darkgray.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-skyblue/tip-skyblue.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-twitter/tip-twitter.css" type="text/css" />
<link rel="stylesheet" href="/resource/libs/plugin/tip-green/tip-green.css" type="text/css" />


<section class="contents " role="main">
	<div class="wrap-cont">

		<h2 class="tit-cont">${weWiki.we_wiki_title }</h2>

		<div class="body-cont wiki" id="wikiViewArea">
			<article class="viewer" style="word-wrap :break-word">
			<c:if test="${!empty summaryList}">
				<div class="index" id="contentsLayer">
					<div class="inner">
						<h2><input type="checkbox" id="hiddenContents"> Table of Contents </h2>
						<div class="box">
							<ul>
								<c:forEach items="${summaryList }" var="summaryList">

								<c:if test="${summaryList.we_summary_tag eq 'h1' }">
								<li>
									<a href="#${summaryList.we_summary_title }">${summaryList.we_summary_title }</a>
								</li>
								</c:if>
								<c:if test="${summaryList.we_summary_tag eq 'h2' }">
								<li class="lv2" >
									<a href="#${summaryList.we_summary_title }">${summaryList.we_summary_title }</a>
								</li>
								</c:if>
								<c:if test="${summaryList.we_summary_tag eq 'h3' }">
								<li class="lv3" >
									<a href="#${summaryList.we_summary_title }">${summaryList.we_summary_title }</a>
								</li>
								</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</c:if>

			${weWiki.we_wiki_markup }

			<c:if test="${!empty noteList or !empty linkList or !empty tagList or !empty fileList}">
			<hr>
			</c:if>

			<div class="foot-info">

			<c:if test="${!empty linkList }">
			<h5 style="padding-bottom:5px">링크 목록</h5>
			<ul>
				<c:forEach items="${linkList }" var="linkList" varStatus="idx">
					<li>${linkList.we_link_text } - ${linkList.we_link_url }</li>
				</c:forEach>
			</ul>
			</c:if>

			<c:if test="${!empty tagList }">
			<h5 style="padding-bottom:5px">관련 키워드</h5>
			<span>
			<c:forEach items="${tagList }" var="tag" varStatus="idx">
			<a href="/space/tag/${tag.we_tag }">${tag.we_tag }</a>
			<c:choose>
				<c:when test="${idx.last}"></c:when>
				<c:otherwise>,</c:otherwise>
			</c:choose>
			</c:forEach>
			</span>
			</c:if>

			<c:if test="${!empty fileList }">
			<h5 style="padding-bottom:10px">첨부파일목록</h5>
			<span>
			<c:forEach items="${fileList }" var="fileList" varStatus="idx">
				<a style="cursor:pointer" name="targetFiles" onclick="javascript:downloadFileServer('${fileList.we_file_idx }', '${fileList.we_file_real_name }');" title="${fileList.we_file_real_name }"><img src="/resource/glider/front/images/file/ic_file_${fn:toUpperCase(fileList.we_file_type)}.jpg"></a> &nbsp;&nbsp;
			</c:forEach>
			</span>
			</c:if>
			</div>

			<c:if test="${!empty noteList }">
			<h5 style="margin-bottom: 0; padding-bottom:5px">주석</h5>
			<div>
			<c:set var="noteCnt" value="0" />
			<c:forEach items="${noteList }" var="noteList" varStatus="idx">
				<c:set var="noteCnt" value="${noteCnt + 1 }" />
				${noteCnt }. <a href="#note-sub-${noteCnt }" ><span id="note-${noteCnt }" name="note-${noteCnt }">${noteList.we_wiki_note_name }</span></a> : ${noteList.we_wiki_note_desc }<br>
			</c:forEach>
			</div>
			</c:if>


			<c:if test="${!empty noteList or !empty linkList or !empty tagList or !empty fileList}">
			<hr>
			</c:if>

			<div class="util" id="utilArea">
					<div class="wrap-btn">
						<a href="javascript:addAgree();" class="btn-wiki" id="addAgree">공감하기</a>
						<a href="#" class="btn-wiki" id="addFavorite" data-space-idx="${weWiki.we_space_idx}" data-wiki-idx="${weWiki.we_wiki_idx}">즐겨찾기</a>
						<a href="javascript:addQuota();" class="btn-wiki" id="addQuota">신고하기</a>
						<a href="javascript:addFriend();" class="btn-wiki" id="addFriend">관심인맥추가</a>
						<a href="javascript:printView();" class="btn-wiki" id="printView">인쇄하기</a>
						<a href="javascript:htmlDownload('${weWiki.we_wiki_idx}', '${weWiki.we_wiki_title }');" class="btn-wiki" id="htmlDownload">HTML로 저장</a>
						<a href="javascript:fullscreen('${weWiki.we_wiki_idx}');" class="btn-wiki" id="fullscreen">전체화면 보기</a>
					</div>
					<div class="info">
						<table>
							<tr>
								<th scope="row">작성자</th>
								<th>${userNick}</th>
							</tr>
							<tr>
								<td>작성일</td>
								<td>${gf:articleDate(weWiki.we_ins_date,'yyyy.MM.dd hh:mm:ss')}</td>
							</tr>
							<tr>
								<td>수정일</td>
								<td>${gf:articleDate(weWiki.we_upd_date,'yyyy.MM.dd hh:mm:ss')}</td>
							</tr>
							<tr>
								<td>조회수</td>
								<td>${weWiki.we_wiki_view_cnt }</td>
							</tr>
							<tr>
								<td>공감수</td>
								<td id="agree_count">${weWiki.we_wiki_agree }</td>
							</tr>
							<tr>
								<td>글상태</td>
								<td>${protectStatus }</td>
							</tr>
						</table>
					</div>
				</div>
				
			</article>			
		</div>
		
		<div class="foot-cont">
			<a href="/wiki/new/${weWiki.we_space_idx}/${weWiki.we_wiki_idx}" class="btn">자식위키 생성</a>
			<c:choose>
				<c:when test="${weWiki.we_wiki_protect eq 2}">
					<a href="javascript:protectWiki('${weWiki.we_wiki_idx}');" class="btn">수정하기</a>
				</c:when>
				<c:otherwise>
				<a href="/wiki/edit/${weWiki.we_wiki_idx}" class="btn">수정하기</a>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${loginUser.weGrade eq 3 || loginUser.weGrade eq 8 || loginUser.weGrade eq 9 }">
				<a href="javascript:dellWiki();" class="btn">삭제하기</a>
				<a href="javascript:updateWikiProdect();" class="btn">위키잠금</a>
			</c:if>
			<a href="/space/main/${weWiki.we_space_idx}" class="btn">공간메인목록</a>
		</div>	

		<div class="body-cont board" style="padding: 36px 65px 35px 65px; margin-top:25px;border-top:1px solid #D8D8D8">
			<div class="view-board">
			
				<div class="form-cmt" id="_comment">
					<form:form modelAttribute="WeWikiComment" name="WeWikiComment" id="WeWikiComment" method="POST" action="/wiki/${weWiki.we_wiki_idx}/insertComment">
					<input type="hidden" name="weWikiCommentIdx" id="weWikiCommentIdx" />
					<input type="hidden" name="weWikiIdx" id="weWikiIdx" />
						<table>
							<colgroup>
								<col style="width:20%;" />
								<col style="width:30%;" />
								<col style="width:20%;" />
								<col style="width:30%;" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">작성자</th>
									<td colspan="3">
										<input type="text" name="userNick" value="${loginUser.weUserNick}" disabled />
										<form:hidden path="we_ins_name" class="title" value="${loginUser.weUserNick}"/>
									</td>
								</tr>
								<tr>
									<th scope="row">보안문자</th>
									<td>
										<input type="text" name="noSpam" id="noSpam" />
										<input type="hidden" name="randomKey" id="randomKey" value="${randomKey}"/>
									</td>
									<th scope="row" colspan="2">스팸 방지 보안문자 [<b>${randomKey}</b>]</th>
								</tr>
								<tr class="content">
									<th scope="row">내용</th>
									<td colspan="3">
										<form:textarea path="we_bbs_text" id="we_bbs_text" value="" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center" id="commentStatus"><button type="button" id="commentInsert" class="btn">댓글저장</button></th>
								</tr>
							</tbody>
						</table>
					</form:form>
				</div>
				<ul class="list-cmt">
					<c:forEach var="commentList" items="${commentList}" varStatus="row">
					<li>
						<div class="head">
							<strong>
								<a href="#">${commentList.we_ins_name} </a>
							</strong>
							<span class="time">${gf:articleDate(commentList.we_ins_date,'yyyy.MM.dd HH:mm:ss')}</span>
							<div class="util">
								<a href="javascript:callModify('${commentList.we_wiki_comment_idx}', '${commentList.we_wiki_idx}', '${commentList.we_ins_user}');" class="btn-edit" title="수정">수정</a>
								<a href="javascript:callDelete('${commentList.we_wiki_comment_idx}', '${commentList.we_wiki_idx}', '${commentList.we_ins_user}');" class="btn-del" title="삭제">삭제</a>
							</div>
						</div>
						<div class="content">
							${fn:replace(commentList.we_bbs_text, lf, "<br/>")}
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>		
			
</section>

<iframe name="fileDownload" width="0" height="0" frameborder="0"  style="display:hidden"></iframe>

<form id="downloadForm" name="downloadForm" method="POST" action="">
<input type="hidden" id="we_file_idx" name="we_file_idx" value="" />
<input type="hidden" id="we_wiki_idx" name="we_wiki_idx" value="" />
<input type="hidden" id="we_wiki_title" name="we_wiki_title" value="" />
<input type="hidden" id="file_name" name="file_name" value="" />
</form>


<js:scripts>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/WikiFunctionService.js'></script>
<script type='text/javascript' src='/dwr/interface/AdminWikiService.js'></script>
<script type="text/javascript" src="/resource/libs/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/resource/libs/jquery/jquery.printArea.js"></script>
<script type="text/javascript" src="/resource/libs/plugin/jquery.poshytip.js"></script>
<script type="text/javascript">

//<![CDATA[
     <%-- 하이라이트 실행 --%>
    SyntaxHighlighter.all();


	$(document).ready(function() {

		$('a[name="targetFiles"]').each(function(i) {
			$(this).live("mouseenter", function(){}).poshytip({
				className: 'tip-twitter',
				bgImageFrameSize: 15,
				showTimeout: 200,
				alignTo: 'target',
				alignX: 'center',
				offsetY: 40,
				allowTipHover: false,
				fade: false,
				slide: false
			});
		});



		$("#hiddenContents").click(function() {
			$("#contentsLayer").hide();
		});
		
		<c:if test="${!empty wikiGraph }">
			<c:forEach begin="1" end="${wikiGraph.we_graph_cnt }" var="i">
			graph${i }();
			</c:forEach>
		</c:if>

		$("#addFavorite").on("click", function(e) {
			e.preventDefault();

			var spaceIdx = $(this).data("spaceIdx");
			var wikiIdx = $(this).data("wikiIdx");

			GliderWiki.confirm("위키 즐겨찾기추가","해당위키를 즐겨찾기에 추가하시겠습니까?",
				function() {
					$.post("/wiki/addFavorite", {favoriteType:'WIKI',spaceIdx:spaceIdx,wikiIdx:wikiIdx}, function(data){
				 		if(data == 1) {
				 			GliderWiki.alert("위키 즐겨찾기","추가되었습니다");
						} else {
							GliderWiki.alert("위키 즐겨찾기","이미 추가된 위키입니다.");
						}
					})
				}
			);
		});
		
		// 댓글 저장 		
		$("#commentInsert").bind("click", function(e){
			e.preventDefault();
			var isGuest = "${loginUser.guest}";
			var noSpam = $("#noSpam").val();
			var randomKey = $("#randomKey").val();
			var text = $("#we_bbs_text").val();
			
			if(checkValid(isGuest, text, noSpam, randomKey)) {
				GliderWiki.confirm('확인 ', '작성한 글을 저장하겠습니까?',  function() { 
					$("#WeWikiComment").submit();	
				});					
			}
			
		});
		
		// 댓글 수정 
		$("#commentUpdate").live("click", function(){
			var isGuest = "${loginUser.guest}";
			var noSpam = $("#noSpam").val();
			var randomKey = $("#randomKey").val();
			var text = $("#we_bbs_text").val();
			var weWikiCommentIdx = $("#weWikiCommentIdx").val();
			var weWikiIdx = $("#weWikiIdx").val();
			
			if(checkValid(isGuest, text, noSpam, randomKey)) {
				GliderWiki.confirm('확인 ', '해당글을 수정하겠습니까?',  function() {
					$.post("/wiki/"+weWikiIdx+"/updateComment", {weWikiCommentIdx:weWikiCommentIdx,weBbsText:text}, function(data){
						if(data.result == 'SUCCESS'){
							$(location).attr('href', "/wiki/"+weWikiIdx);	
						} else {
							GliderWiki.alert("에러","에러가 발생 하였습니다. 다시 시도 하세요.");
						}
					});	
				});
			}
		});
		
	});

	 <%-- 01. 공감추가 --%>
	function addAgree(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		WikiFunctionService.updateAgreeUserInsert("${weWiki.we_wiki_idx}" , weUserIdx, callBackWikiAgreeAdd);
	}

	<%-- 02. 관심인맥 추가 --%>
	function addFriend(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		WikiFunctionService.addUserFriend("${loginUser.weUserIdx}","${weWiki.we_ins_user}", callBackWikiCommand);
	}

	<%-- 03. 즐겨찾기 --%>
	function addFavorite(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		var spaceIdx = $(this).data("spaceIdx");
		var wikiIdx = $(this).data("wikiIdx");

		//WikiFunctionService.addWikiFavorite("${loginUser.weUserIdx}","${weWiki.we_wiki_idx}", "${weWiki.we_space_idx}", callBackWikiCommand);
	}

	<%-- 04. 신고하기 --%>
	function addQuota(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		WikiFunctionService.addWikiQuota("${weWiki.we_wiki_idx}", callBackWikiCommand);
	}

	<%-- 05. 위키삭제 --%>
	function dellWiki(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		GliderWiki.confirm("확인", "삭제하겠습니까?", function () {
			AdminWikiService.entityDeleteWiki("${weWiki.we_wiki_idx}", "${weWiki.we_wiki_revision}", weUserIdx, callBackWikiDel);
		});

	}

	<%-- 06. 잠금하기 --%>
	function updateWikiProdect(){
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		WikiFunctionService.updateWikiProdectStatus("${weWiki.we_wiki_idx}", callBackWikiCommand);
	}


	// 공감추가 콜백
	function callBackWikiAgreeAdd(obj) {
 		if(obj != null) {
			if(obj > 0) {
				GliderWiki.alert('결과','공감이 추가 되었습니다.');
				$("#agree_count").html(obj);
				return;
			} else if( obj == -1 ) {
				GliderWiki.alert('결과','현재 위키에 이미 공감을 했습니다.');
				return;
			} else if( obj == -2 ) {
				GliderWiki.alert('결과','공감 처리 중 에러가 발생하였습니다.');
				return;
			} else if( obj == -3 ) {
				GliderWiki.alert('결과','본인이 작성한 글에는 공감하기 버튼을 클릭할 수 없습니다.');
				return;
			}

		} else {
			GliderWiki.alert('결과','결과값이 없습니다. 다시 시도하세요.');
			return;
		}
	}

	// 공감추가 콜백
	function callBackWikiCommand(obj) {
 		if(obj != null) {
 			GliderWiki.alert("결과",obj);
		} else {
			GliderWiki.alert("결과",obj);
		}
	}

	// 삭제 콜백
	function callBackWikiDel(obj) {
		GliderWiki.alert("결과",obj.msg);
 		if(obj.flag == "success") {
 			$("#okBtn").click(function () {
 				location.replace("<c:url value="/space/main/${weWiki.we_space_idx}" />");
			});
		}
	}

	function printView() {
		var weUserIdx = "${loginUser.weUserIdx}";	// 세션 유저 아아디

		if(weUserIdx == '0' || weUserIdx == '') {
			GliderWiki.alert('확인','로그인 정보가 없습니다. 로그인 후 시도하세요.');
			return;
		}

		$("#utilArea").hide();

		$("#wikiViewArea").printArea({
			mode     : "popup",
			popClose : false,
            popWd    : 1000,
			popHt    : 740,
            popX     : 1,
            popY     : 1,
            hiddenId : "utilArea",
			popTitle:"Enterprise OpenSource Wiki GLiDER™"
		});
	}


	function downloadFileServer(we_file_idx, real_name){
		GliderWiki.confirm("확인", real_name + " 파일을 다운로드 하겠습니까?", function () {
			$('#downloadForm input[name=we_file_idx]').val(we_file_idx);
			$("#downloadForm").attr("target", "fileDownload");
			$("#downloadForm").attr("action", "/wiki/download").submit();
		});
	}

	/**
	 * HTML 파일 생성하기 
	 */
	function htmlDownload(we_wiki_idx, we_wiki_title) {
		GliderWiki.confirm("확인", "현재 문서를 HTML 파일로 다운로드 하겠습니까?", function () {
			$('#downloadForm input[name=we_wiki_idx]').val(we_wiki_idx);
			$('#downloadForm input[name=we_wiki_title]').val(we_wiki_title);
			$.post("/wiki/htmlDownload", {"we_wiki_idx":we_wiki_idx,"we_wiki_title":we_wiki_title}, function(data){
				if(data.result == 'SUCCESS'){
		 			downloadHtmlFile(data.filename);
				} else {
					$.loadingBar.fadeOut();
					GliderWiki.alert('경고','HTML 생성중 에러가 발생했습니다. 다시 시도하세요.');
					return;
				}
			})
		});
	}
	
	/**
	 * HTML 파일 다운로드 받기 
	 */
	function downloadHtmlFile(filename) {
		$('#downloadForm input[name=file_name]').val(filename);
		$("#downloadForm").attr("target", "fileDownload");
		$("#downloadForm").attr("action", "/wiki/getHtmlFile").submit();
	}
	
	/**
	 * fullscreen 모드 
	 */
	function fullscreen(we_wiki_idx) {
		var url = "${domain}wiki/fullscreen/"+we_wiki_idx;
		openFullWindow(false, url);
	}
	
	function openFullWindow(Option, url) {
		var screenSizeWidth, screenSizeHeight;
		if (self.screen) {
			screenSizeWidth = screen.width;
			screenSizeHeight = screen.height;
		}

		documentURL = url;
		windowname = "wmname";
		intWidth = screenSizeWidth;
		intHeight = screenSizeHeight;
		intXOffset = 0;
		intYOffset = 0;
		if (Option) {
			obwindow = window.open(
							documentURL,
							windowname,
							"fullscreen=yes, toolbar=no, location=no, directories=no, status=no, menubar=no,scrollbars=no,resizable=no");
		} else {
			obwindow = window.open(
							documentURL,
							windowname,
							"fullscreen=yes,toolbar=no, location=no, directories=no, status=no, menubar=no,scrollbars=auto,resizable=no");
			obwindow.resizeTo(intWidth, intHeight);
			obwindow.moveTo(intXOffset, intYOffset);
		}
	}
	
	function protectWiki(wikiIdx) {
		var grade = '${loginUser.weGrade}';
		if(grade < 3) {
			GliderWiki.alert('확인','잠금상태의 글을 수정 할 수 없습니다.');
			return;
		} else {
			$(location).attr('href',"/wiki/edit/"+wikiIdx);	
		}
		
	}
	
	/**
	 * 댓글 수정 
	 */
	function callModify(weWikiCommentIdx, weWikiIdx, userIdx){
		location.href = "#_comment";
		var weUserIdx = '${loginUser.weUserIdx}';
		var isGuest = "${loginUser.guest}";
		
		if(weUserIdx != userIdx || isGuest == "true") {
			GliderWiki.alert("에러","수정 권한이 없습니다.");
			return;
		}
		
		$.ajax({
			type:"GET"
			,url:"/wiki/"+weWikiIdx+"/getComment"
			,data:{"weWikiCommentIdx":weWikiCommentIdx,"weUserIdx":weUserIdx,"weWikiIdx":weWikiIdx}
			,dataType:"json"
			,success:function(rtnObj){
				if(rtnObj.result == 1) {
					$("#we_bbs_text").val(rtnObj.contents);	
					$("#commentStatus").html("<button type=\"button\" id=\"commentUpdate\" class=\"btn\">댓글수정</button>");
					$("#weWikiCommentIdx").val(weWikiCommentIdx);
					$("#weWikiIdx").val(weWikiIdx);
				} else {
					GliderWiki.alert("에러","잘못된 접근입니다");
					return;
				}
				
			}
		});
	}

	/**
	 * 댓글 삭제 
	 */
	function callDelete(weWikiCommentIdx, weWikiIdx, userIdx){
		var weUserIdx = '${loginUser.weUserIdx}';
		var weGrade = "${loginUser.weGrade}";
		var weUserIdx = '${loginUser.weUserIdx}';

		if(userIdx == weUserIdx || weGrade == '9') {
			GliderWiki.confirm('확인 ', '해당글을 삭제 하겠습니까?',  function() {
				$.post("/wiki/"+weWikiIdx+"/deleteComment", {weWikiCommentIdx:weWikiCommentIdx,weUserIdx:weUserIdx}, function(data){
					if(data.result == 'SUCCESS'){
						$(location).attr('href', "/wiki/"+weWikiIdx);	
					} else {
						GliderWiki.alert("에러","에러가 발생 하였습니다. 다시 시도 하세요.");
					}
				});	
			});
		} else {
			GliderWiki.alert("에러","수정 권한이 없습니다.");
			return;
		}
	}

	/**
	 * 댓글 체크 
	 */
	function checkValid(isGuest, text, noSpam, randomKey) {
		if(isGuest == "true") {
			GliderWiki.alert("에러","권한이 없습니다.로그인 후 이용하세요.");
			return false;
		}
		if(GliderWiki.Utils.isEmpty(text)) {
			GliderWiki.alert("에러","내용을  입력하셔야 합니다.");
			return false;
		}
		if(GliderWiki.Utils.isEmpty(noSpam) || noSpam != randomKey) {
			GliderWiki.alert("에러","보안 문자가 올바르지 않습니다.");
			return false;
		}
		return true;
	}


//]]>
</script>
</js:scripts>
