<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:url var="APIURL" value="/api/new"/>
<c:url var="newURL" value="/admin/new/list"/>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Danh sách bài viết</title>
	</head>

	<body>
		<div class="main-content">
		<form action="<c:url value = "/admin/new/list"/>" id="formSubmit" method="get">
			
				<div class="main-content-inner">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="#">Trang chủ</a>
							</li>
						</ul>
						<!-- /.breadcrumb -->
					</div>
					<div class="page-content">
						<div class="row">
							<c:if test="${not empty message}">
								<div class="alert alert-${alert}">
				                    ${message}
				                </div>
							</c:if>
							
							<div class="col-xs-12">
								<div class="widget-box table-filter">
									<div class="table-btn-controls">
										<div class="pull-right tableTools-container">
											<div class="dt-buttons btn-overlap btn-group">
												<c:url var="creatNewURL" value="/admin/new/add"></c:url>
												<a class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												   title='Thêm bài viết' href='${creatNewURL}'>
															<span>
																<i class="fa fa-plus-circle bigger-110 purple"></i>  Create
															</span>
												</a>
												<button id="btnDelete" type="button" onclick="warningBeforeDelete()" 
														class="dt-button buttons-html5 btn btn-white btn-primary btn-bold" title='Xóa bài viết'>
																<span>
																	<i class="fa fa-trash-o bigger-110 pink"></i>  Delete</span>
												</button>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="table-responsive">
											<table class="table table-bordered">
												<thead>
													<tr>
														<th><input type="checkbox" id="checkAll"></th>
														<th>ID</th>
														<th>Title</th>
														<th>Short description</th>
														<th>Content</th>
														<th>Update</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${model.listResult}">
														<tr>
															<td><input type="checkbox" id="checkbox_${item.id}" value="${item.id}">
															</td>
															<td>${item.id}</td>
															<td>${item.title}</td>
															<td>${item.shortDescription}</td>
															<td>${item.content}</td>
															<td>			
																<c:url var="editNewURL" value="/admin/new/edit">
																	<c:param name="id" value="${item.id}"></c:param>
																</c:url>													
																<a class="btn btn-sm btn-primary btn-edit"
																   title="Cập nhật bài viết" href='${editNewURL}'><i class="fa fa-pencil-square-o"></i>
																	Update
																</a>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											
											<center><ul class="pagination" id="pagination"></ul></center>
											<input type="hidden" value="" id="page" name="page"/>
											<input type="hidden" value="" id="limit" name="limit"/>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		</form>
		</div>
		<!-- /.main-content -->
		<script>
			var totalPages = ${model.totalPage};
			var currentPage = ${model.page};
			var limit = 3;
		
			$(function () {
		        window.pagObj = $('#pagination').twbsPagination({
		            totalPages: totalPages,
		            visiblePages: 2,
		            startPage : currentPage,
		            onPageClick: function (event, page) {
		                if (currentPage != page) {
							$('#limit').val(limit);
							$('#page').val(page);
							$('#formSubmit').submit();
		                }
		            }
		        });
		    });

			function warningBeforeDelete() {
				swal({
				  title: "Are you sure?",
				  text: "Your will not be able to recover this imaginary file!",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonClass: "btn-success",
				  cancelButtonClass: "btn-danger",
				  confirmButtonText: "Delete",
				  cancelButtonText: "Cancel",
				}).then(function (result) {
				    if (result.value) {
				    	//var data = {};
						var ids = $('tbody input[type=checkbox]:checked').map(function () {
				            return $(this).val();
				        }).get();
						//data['ids'] = ids;
						deleteNew(ids);
				    }
				});
			}
			
			function deleteNew(data) {
		        $.ajax({
		            url: '${APIURL}',
		            type: 'DELETE',
		            contentType: 'application/json',
		            data: JSON.stringify(data),
		            success: function (result) {
		                window.location.href = "${newURL}?page=1&limit=3&message=delete_success";
		            },
		            error: function (error) {
		            	window.location.href = "${newURL}?page=1&limit=3&message=system_error";
		            }
		        });
		    }
		</script>
	</body>

	</html>