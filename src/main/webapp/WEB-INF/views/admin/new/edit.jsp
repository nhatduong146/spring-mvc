<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="APIURL" value="/api/new"/>
<c:url var="newURL" value="/admin/new/list"/>
<c:url var="editURL" value="/admin/new/edit"/>

<html>
<head>
    <title>Chỉnh sửa bài viết</title>
</head>
<body>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Trang chủ</a>
                    </li>
                    <li class="active">Chỉnh sửa bài viết</li>
                </ul><!-- /.breadcrumb -->

            </div>
            <div class="page-content">
               	<c:if test="${not empty message}">
					<div class="alert alert-${alert}" role="alert">
	                    ${message}
	                </div>
				</c:if> 
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-7">
                        <br>
                        <form:form action = "/api/new" modelAttribute="model" id="formSubmit">
                        	<form:hidden path="id" id="newId"/>
                            <div class="form-group row">
                                <label for="sel1" class="col-sm-2 text-info" >Category:</label>
                                <div class="col-sm-2" align="center">
                                    <form:select class="form-control" path="categoryCode" >
                                    	<form:option value="NONE" label="--Category--"/>
                                    	<form:options items="${categories}"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 text-info">Title:</label>
                                <div class="col-sm-10">
                                  	<form:input path="title" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-sm-2 text-info" for="email">Thumbnail:</label>
                                <div class="col-sm-8">
                                  <input type="file" name="Image file">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="shortDescription" class="control-label col-sm-2 text-info">Short description:</label>
                                <div class="col-sm-10">
                                     <form:textarea path="shortDescription" class="form-control" rows="4" id="shortDescription"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="contetn" class="control-label col-sm-2 text-info">Content</label>
                                <div class="col-sm-10">
                                      <form:textarea path="content" class="form-control" rows="5" id="content"/>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4"></div>
                                <c:if test="${not empty model.id}">
	                                <div class="col-sm-2">
	                                      <button type="button" class="btn btn-info" id="btnAddOrUpdateNew">Update</button>
	                                </div>
                                </c:if>
                                <c:if test="${empty model.id}">
	                                <div class="col-sm-2">
	                                      <button type="button" class="btn btn-info" id="btnAddOrUpdateNew">Create</button>
	                                </div>
                                </c:if>
                                <div class="col-sm-2">
                                      <a href='<c:url value="/admin/new/list?page=1&limit=3"/>'><button type="button" class="btn btn-info">Cancel</button></a>
                                </div>
                            </div>
                        </form:form>
            	</div>
        </div>
    </div>
</div>
</div>

<script>

	$(document).ready(function(){
		var editor = CKEDITOR.replace( 'content' );
	    CKFinder.setupCKEditor( editor, '<c:url value ="/template/ckfinder/"/>');
	});
	
	$('#btnAddOrUpdateNew').click(function (e) {
	    e.preventDefault();
	    var data = {};
	    var formData = $('#formSubmit').serializeArray();
	    $.each(formData, function (i, v) {
            data[""+v.name+""] = v.value;
        });
        data['content'] = CKEDITOR.instances['content'].getData();
		var id = $('#newId').val();
        if (id == "") {
            addNew(data);
        } else {
            updateNew(data);
        }
	});
	
	function addNew(data) {
        $.ajax({
            url: '${APIURL}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	window.location.href = "${editURL}?message=insert_success";
            },
            error: function (error) {
            	window.location.href = "${newURL}?page=1&limit=3&message=system_error";
            }
        });
    }
	
    function updateNew(data) {
        $.ajax({
            url: '${APIURL}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	window.location.href = "${editURL}?id="+result.id+"&message=update_success";
            },
            error: function (error) {
            	window.location.href = "${newURL}?page=1&limit=3&message=system_error";
            }
        });
    }
</script>
</body>
</html>
