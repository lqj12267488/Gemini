<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="resourceCourseId" hidden value="${data.resourceCourseId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceCourseName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="15" placeholder="最多输入15个字" value="${data.resourceCourseName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程排序
                    </div>
                    <div class="col-md-9">
                        <input id="resourceCourseOrder" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="10" placeholder="最多输入10个字" value="${data.resourceCourseOrder}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectIdd" onchange="changeData()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorIdd" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"
                               maxlength="150" placeholder="最多输入150个字" value="${data.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="upResourceMajorId" name="upResourceMajorId" value="${data.resourceMajorId}" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {


        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceSubjectIdd",'${data.resourceSubjectId}');
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR ",
                //orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceMajorIdd",$("#upResourceMajorId").val());
            })

        if('${data.resourceCourseId}'!=""){
            $("#resourceSubjectId").attr('disabled','disabled');
            $("#resourceMajorId").attr('disabled','disabled');
        }else{
            $("#resourceSubjectId").blur(function(){
                if( $("#resourceSubjectId").val()!="" ){
                    $.get("<%=request.getContextPath()%>/common/getTableDict",{
                            id: " resource_major_id ",
                            text: " resource_major_name ",
                            tableName: " ZYK_TYPE_MAJOR ",
                            where: " where RESOURCE_SUBJECT_ID ='"+$("#resourceSubjectId").val()+"'",
                            orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
                        },
                        function (data) {
                            addOption(data, "resourceMajorId",'${data.resourceMajorId}');
                        })
                }
            });

        }
    });
    function changeData(){
        var resourceSubjectIdd=$("#resourceSubjectIdd").val();
        if(resourceSubjectIdd!=""){
            var major_sql = "(select resource_major_id code,resource_major_name value from ZYK_TYPE_MAJOR";
             major_sql+= " where RESOURCE_SUBJECT_ID ='"+resourceSubjectIdd+"'  ";
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    //orderby: "  LPAD(RESOURCE_MAJOR_ORDER,5,'0') "
                },
                function (data) {
                    addOption(data, "resourceMajorIdd",'${data.resourceMajorId}');
                })

        }
    }

    function save() {
        var resourceCourseId = $("#resourceCourseId").val();
        var resourceCourseName = $("#resourceCourseName").val();
        var resourceCourseOrder = $("#resourceCourseOrder").val();
        var resourceMajorId = $("#resourceMajorIdd").val();
        var resourceSubjectId = $("#resourceSubjectIdd").val();
        var remark = $("#remark").val();
        if (resourceCourseName == "" || resourceCourseName == undefined || resourceCourseName == null) {
            swal({title: "请填写课程名称！",type: "info"});
            return;
        }
        if (resourceCourseOrder == "" || resourceCourseOrder == undefined || resourceCourseOrder == null) {
            swal({title: "请填写课程排序！",type: "info"});
            return;
        }
        var reg = new RegExp("^[1-9][0-9]*$");
        if (!reg.test(resourceCourseOrder)) {
            swal({title: "请填写数字！"});
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({title: "请填写学科！",type: "info"});
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({title: "请填写专业！",type: "info"});
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/resourceLibrary/typeCourse/saveResourceTypeCourse", {
            resourceCourseId:resourceCourseId,
            resourceCourseName:resourceCourseName,
            resourceCourseOrder:resourceCourseOrder,
            resourceMajorId:resourceMajorId,
            resourceSubjectId:resourceSubjectId,
            remark:remark,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: msg.result});
            $("#dialog").modal('hide');
            $('#tableCourse').DataTable().ajax.reload();
        })
    }
</script>



