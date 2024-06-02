<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@include file="includes/header.jsp"%>
<%@include file="includes/leftNav.jsp"%>

	<div class="col-lg-10">
		<div class="panel panel-default">
			<div class="panel-heading">
				Item List Page
				
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			<!-- 검색조건 -->
				  <div class="row">       
				    <div class="col-lg-4">                    
				        <form id='searchForm' action="/admin/item/list" method='get' class='searchForm'>
				            <select class="custom-select" name='type'>
				                <option value=""
				                    <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
				                <option value="P"
				                    <c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>상품명</option>
				                <option value="B"
				                    <c:out value="${pageMaker.cri.type eq 'B'?'selected':''}"/>>브랜드ID</option>
			                    <option value="C"
				                    <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>카테고리ID</option>
				                <option value="I"
				                    <c:out value="${pageMaker.cri.type eq 'I'?'selected':''}"/>>상품번호</option>
				  
				            </select> 
				            <input type='text' class='custom-keyword' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
				            <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
				            <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
				            <button class='btn custom-btn'>Search</button>
				        </form>
				    </div>
				    
				    <div class="col-lg-8 button-add">	
				     	<a href="/admin/item/list" type="button" class="btn btn-board btn-xs btn-dark pull-right btn-info col-lg-2 mx-2 my-2"> 오름차순 </a>
				        <a href="/admin/item/descList" type="button" class="btn btn-board btn-xs pull-right btn-info btn-warning col-lg-2 mx-2 my-2"> 내림차순</a>		       
				    </div>
				</div>
				<!-- end 검색조건 -->
				<button id="regBtn" type="button" class="btn btn-board btn-xs pull-right btn-info col-lg-1 mx-2 my-2" onclick="goToModalForm(); openSelection('brand', 1)"> 새글 </button>
				<a href="/admin/item/list" type="button" class="btn btn-board btn-xs btn-light pull-right btn-info col-lg-2 mx-2 my-2">검색해제 일반리스트 </a>
				<table width="80%"
					class="table table-striped table-bordered table-hover"
					id="dataTables-example">
					
					<caption class="table-caption">상품</caption>
					<thead>
						<tr>
							<th>상품ID</th>
							<th>상품이미지</th>
                            <th>상품명</th>
                            <th>상품재고</th>
                            <th>가격</th>
                            <th>할인율</th>
                            <th>브랜드ID</th>
                            <th>카테고리</th>
                            <th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${items}">
							<tr class="odd gradeX">
								<td><a href='#' id="${item.itemId}" onclick="goToDetailModalForm(this)">${item.itemId}</a></td>
								<td><img src="/download/${item.itemImageURL}" alt="상품이미지" style="max-width: 70px"></td>
								<td>${item.itemName}</td>                             
                                <td>${item.itemStock}</td>
                                <td>${item.itemPrice}</td>
                                <td>${item.itemDiscount}</td>
                                <td>${item.brandName}</td>
                                <td>${item.cateName}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.regDate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- 페이지 처리 -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button"><a class="page-link"
								href="${pageMaker.startPage-1}">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': ''} ">
							<a href="${num}">${num}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button"><a href="${pageMaker.endPage+1}">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!-- end 페이지 처리 -->
				<form id='actionForm' action="/admin/item/list" method='get'>
					<input type='hidden' name='pageNum'
						value='${pageMaker.cri.pageNum}'> <input type='hidden'
						name='amount' value='${pageMaker.cri.amount}'>
						<input type='hidden' name='type' value='${pageMaker.cri.type}'>
						<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
				</form>
				
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- 등록 모달 -->
	<div class="modal" id="formModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog mx-auto" role="document">
			<div class="modal-content" style="width: 500px;">
				<div class="modal-header">
					<h5 class="modal-itemName" id="cartModalLabel">상품 등록</h5>
					<button type="button" class="close" aria-label="Close"
						onclick="closeModal('#formModal')">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body row">
					<form class="col-lg-6" id="registerForm" name="registerForm" role="form" action="register" method="post" enctype="multipart/form-data">
							 <div class="form-group">
								<label>상품명</label> <input type="text"
									class="form-control" name="itemName"
									placeholder="상품명을 입력하세요" required>
							 </div>
		                     <div class="form-group">
			                 <label>브랜드</label>
			                 
			                 <div class="form-group">
	                            <input type="text" class="form-control" id="brandRegName" name="brandName" placeholder="(우측 또는 하단)브랜드 목록에서 선택해주세요" readonly required>
	                            <input type="hidden" id="brandRegId" name="brandId">	                       
	                        </div>
				                
				             </div>
		                     <div class="form-group">
		                        <label>제조연도</label> <input class="form-control"
		                           name='mnfcYear' placeholder="제조연도" required>
		                     </div>
		                     <div class="form-group">
		                        <label>제조사</label> <input class="form-control"
		                             name='manufacturer'placeholder="제조사" required>
		                     </div>
		                     
		                     <div class="form-group">
								  <select id="categorySelect" class="btn btn-outline-dark my-2" onchange="openSelection('itemCate', 1)">
								  		<option disabled selected>카테고리</option>
									    <c:forEach var="category" items="${categorys}">
									      	<option value="${category.cateCode}">${category.cateName}</option>
									    </c:forEach>
								  </select>
							</div>
							<div class="form-group row">
								<div class="form-group-append col-lg-6">
									  <label>카테고리ID</label>
									  <input class="form-control" id="categoryRegId" name="cateCode" placeholder="카테고리" readonly required>
								</div>
								<div class="form-group-append col-lg-6">
									  <label>카테고리명</label>
									  <input class="form-control" id="categoryRegName" name="cateName" placeholder="카테고리" readonly required>
								</div>
		                     </div>
							 
							 
	                     <div class="form-group">
	                        <label>가격</label> <input class="form-control"
	                             name='itemPrice'placeholder="가격" required>
	                     </div>
	                     <div class="form-group">
	                        <label>재고</label> <input class="form-control"
	                             name='itemStock' placeholder="재고" required>
	                     </div>
	                     <div class="form-group">
	                        <label>할인율</label> <input class="form-control"
	                            name='itemDiscount' placeholder="할인율" required>
	                     </div>
	                     <div class="form-group">
	                        <label>상품 소개</label> <textarea class="form-control"
	                        rows="3" name='itemIntro' placeholder="상품 소개" required></textarea>
	                     </div>
	                     <div class="form-group">
	                        <label>상품 설명</label> <textarea class="form-control"
	                        rows="5" name='itemContents' placeholder="상품 설명" required></textarea>
	                     </div>
	
	                     <div class="form-group">
	                        <label for="uploadFile">uploadFile</label>
	                        <input type="file" id="uploadFile" name="uploadFile" multiple>
	                        <input type="hidden" value='defaltImage.jpg' name='itemImageURL'>
	                     </div>
	
						 <button type="submit" class="btn btn-default btn-success">Submit Button</button>
						 <button type="reset" class="btn btn-secondary">다시 작성</button>
						 <button type="button" class="btn btn-secondary" onclick="closeModal(this)">list</button>
					</form>
					 <!-- 브랜드 선택 목록 -->
					 <div class="panel panel-default col-lg-6">
	                    <div class="panel-body">
						    <label>브랜드</label>
						    <ul class="list-group" style="height: 252px;" id="brand-list"></ul>
						    <ul class='pull-right pagination' id="brand-pagination"></ul>
						</div>
						                    
						<div class="panel-body">
						    <label>카테고리 2</label>
						    <ul class="list-group" id="itemCate-list"></ul>
						    <ul class='pull-right pagination' id="itemCate-pagination"></ul>
						</div>
                    </div>
	            </div>
	        </div>
	    </div>
				</div>
			</div>
		</div>
	</div>



<!-- 상세 수정 삭제 모달 -->
<div class="modal" id="formModal2" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-itemName" id="cartModalLabel">회원 수정</h5>
				<button type="button" class="close" aria-label="Close"
					onclick="closeModal(this)">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="modifyForm" action="modify" method="post" enctype="multipart/form-data">
	        
				<div class="form-group">
					<label>상품 ID</label> <input class="form-control" name='itemId' id='itemId' readonly>
				</div>
				<div class="form-group">
					<label>상품명</label> <input class="form-control"
						id='itemName' name='itemName'>
                </div>

	             <div class="form-group">
                    <label>제조연도</label> <input class="form-control"
                        id='mnfcYear' name='mnfcYear'>
                </div>

                <div class="form-group">
                    <label>제조사</label> <input class="form-control"
                        id='manufacturer' name='manufacturer'>
                </div>
                
                <div class="form-group">
                    <label>브랜드ID</label> <input class="form-control"
                        id='brandId' name='brandId'>
                </div>
                
                <div class="form-group">
                    <label>브랜드명</label> <input class="form-control" id='brandName' name='brandName'>
                </div>

                <div class="form-group">
                    <label>카테고리ID</label> <input class="form-control"
                        id='cateCode' name='cateCode'>
                </div>
                  <div class="form-group">
                    <label>카테고리명</label> <input class="form-control"
                        id='cateName' name='cateName'>
                </div>

                <div class="form-group">
                    <label>가격</label> <input class="form-control"
                        id='itemPrice' name='itemPrice'>
                </div>

                <div class="form-group">
                    <label>재고</label> <input class="form-control"
                        id='itemStock' name='itemStock' readonly>
                </div>

                <div class="form-group">
                    <label>할인율</label> <input class="form-control"
                        id='itemDiscount' name='itemDiscount'>
                </div>

                <div class="form-group">
                    <label>상품 소개</label> <textarea class="form-control"
                    rows="3" id='itemIntro' name='itemIntro'></textarea>
                </div>

                <div class="form-group">
                    <label>상품 설명</label> <textarea class="form-control"
                    rows="5" id='itemContents' name='itemContents'></textarea>
                </div>
                
				
                <div class="form-group">
                    <input type='file' name='uploadFile' multiple>
                </div>

                <div class="form-group">
                    <label>변경전 이미지</label>
                    <div class="row">
                    	<img src="" alt="상품이미지" style="max-width: 250px" id='imageSRC'>
                    	<input type="hidden" name='itemImageURL' id='imageID'>
                    </div>
                </div>
			
                <div class="form-group">
					<label for="regDate">등록일</label> <input type="text"
						id="regDate" class="form-control" readonly>					
				</div>

                <div class="form-group">
					<label for="updateDate">수정일</label> <input type="text"
						id="updateDate" class="form-control" readonly>					
				</div>
				
				<button type="submit" class="btn btn-default">Modify</button>
				<button type="submit" onclick="removeAction()" class="btn btn-danger">Remove</button>
				<button type="button" class="btn btn-secondary" onclick="closeModal(this)">list</button>
				<input type="hidden" id="currentPath" name="currentPath" value="">
				</form>
			</div>
		</div>
	</div>
</div>

<%@include file="includes/footer.jsp"%>
<script>
function openSelection(type, page) {
    showList(type, page);
}

function showList(type, page) {
    var listUL = document.getElementById(type + "-list");
    var paginationUL = document.getElementById(type + "-pagination");
    var pageNum = 1;
    var targeturl = null;

    
    var selectedCateCode = type === "itemCate" ? document.getElementById("categorySelect").value : null;
    
    if(type === "itemCate"){
    	targeturl = "/admin/" + type + "/select/" + page + "/" + selectedCateCode;
    } else {
    	targeturl = "/admin/" + type + "/select/" + page;
    }
    
    
	
    $.ajax({
        url: targeturl,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log(type + " 목록:", response);
            pageNum = response.pageMaker.cri.pageNum;
            var total = response.pageMaker.total;
            var list = response.list;
            console.log(total);

            if (page == -1) {
                pageNum = Math.ceil(replyCnt / 10.0);  // 페이지 수 계산
                showList(type, pageNum);
                return;
            }

            var str = "";

            if (list == null || list.length == 0) {
                listUL.innerHTML = "";
            }

            for (var i = 0, len = list.length || 0; i < len; i++) {
                if (type === "brand") {
                    str += "<li class='list-group-item' onclick=\"selectItem('" + type + "', '" + list[i].brandId + "', '" + list[i].brandName + "')\">" + list[i].brandName + "</li>";
                } else if (type === "itemCate") {
                    str += "<li class='list-group-item' onclick=\"selectItem('" + type + "', '" + list[i].cateCode + "', '" + list[i].cateName + "')\">" + list[i].cateName + "</li>";
                }
            }

            listUL.innerHTML = str;
		
		console.log(total);
            showPageNum(type, pageNum, total);
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });
}

function showPageNum(type, pageNum, total) {
	console.log(total);
    var paginationUL = document.getElementById(type + "-pagination");
    var endNum = Math.ceil(pageNum / 10.0) * 10;
    var startNum = endNum - 9;

    var prev = startNum != 1;
    var next = false;
    
    var str = "";

    if (endNum * 10 >= total) {
        endNum = Math.ceil(total / 10.0);
    }

    if (endNum * 10 < total) {
        next = true;
    }

    if (prev) {
        str += "<li class='paginate_button'><a class='page-link' data-page='" + (startNum - 1) + "' href='#' onclick='handlePageClick(event, \"" + type + "\")'>Previous</a></li>";
    }

    for (var i = startNum; i <= endNum; i++) {
        var active = pageNum == i ? "active" : "";
        str += "<li class='paginate_button " + active + "'><a class='page-link' data-page='" + i + "' href='#' onclick='handlePageClick(event, \"" + type + "\")'>" + i + "</a></li>";
    }

    if (next) {
        str += "<li class='paginate_button'><a class='page-link' data-page='" + (endNum + 1) + "' href='#' onclick='handlePageClick(event, \"" + type + "\")'>Next</a></li>";
    }

    paginationUL.innerHTML = str;
}

function handlePageClick(event, type) {
    event.preventDefault();
    var targetPage = parseInt(event.target.getAttribute("data-page"));
    showList(type, targetPage);
}

function selectItem(type, id, name) {
    if (type === "brand") {
        document.getElementById('brandRegId').value = id;
        document.getElementById('brandRegName').value = name;
    } else if (type === "itemCate") {
        document.getElementById('categoryRegId').value = id;
        document.getElementById('categoryRegName').value = name;
    }
}



function updateActionUrl() {
    var currentUrl = window.location.href;
    var newPath;

    if (currentUrl.includes("desc")) {
        newPath = "/admin/item/descList";
    } else {
        newPath = "/admin/item/list";
    }

    $("#currentPath").val(extractPageName(newPath));
    return newPath;
}



function goToDetailModalForm(element) {
    console.log(element);

    let valueToSend = element.id;
    console.log(valueToSend);

    $.ajax({
        url: '/admin/item/get/' + valueToSend,
        type: 'get',
        data: { itemId: valueToSend },
        success: function (response) {
            $("#itemId").val(response.item.itemId);
            $("#itemName").val(response.item.itemName);
            $("#brandId").text(response.item.brandId);
            $("#brandName").text(response.item.brandName);
            var mnfcYear = new Date(response.item.mnfcYear);
            var mnfcYearDateString = mnfcYear.toISOString().substring(0, 10);
            $("#mnfcYear").val(mnfcYearDateString);
            $("#manufacturer").val(response.item.manufacturer);
            $("#cateCode").val(response.item.cateCode);
            $("#cateName").val(response.item.cateName);
            $("#itemPrice").val(response.item.itemPrice);
            $("#itemStock").val(response.item.itemStock);
            $("#itemDiscount").val(response.item.itemDiscount);
            $("#itemIntro").val(response.item.itemIntro);
            $("#itemContents").val(response.item.itemContents);
            var regDate = new Date(response.item.regDate);
            var regDateString = regDate.toISOString().substring(0, 10);
            $('#regDate').val(regDateString);
            var upDateDate = new Date(response.item.updateDate);
            var updateDateDateString = upDateDate.toISOString().substring(0, 10);
            $('#updateDate').val(updateDateDateString);
            $("#imageSRC").attr("src", "/download/" + response.item.itemImageURL);
            $("#imageID").val(response.item.itemImageURL);
            $('#formModal2').modal('show');
        },
        error: function (xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });
}

</script>