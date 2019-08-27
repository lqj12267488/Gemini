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
            <input id="JPKId" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectIdd" onchange="changeData()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorIdd" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseIdd" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        精品课类型
                    </div>
                    <div class="col-md-9">
                        <input id="JPKResourceTypeName" value="${data.jpkTypeName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" value="${data.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="upResourceMajorId" name="upResourceMajorId" value="${data.resourceMajorId}" hidden>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "resourceSubjectIdd",'${data.resourceSubjectId}');
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " resource_major_id ",
                text: " resource_major_name ",
                tableName: " ZYK_TYPE_MAJOR t",
                where: "  where t.resource_subject_id = '"+'${data.resourceSubjectId}'+"'",
                //orderby: " order by LPAD(resource_MAJOR_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceMajorIdd",$("#upResourceMajorId").val());
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_COURSE_ID ",
                text: " RESOURCE_COURSE_NAME ",
                tableName: " ZYK_TYPE_COURSE ",
                where: " where RESOURCE_SUBJECT_ID ='"+"${data.resourceSubjectId}"+"' and RESOURCE_MAJOR_ID = '"+"${data.resourceMajorId}"+"'",
                orderby: "  "
            },
            function (data) {
                addOption(data, "resourceCourseIdd",'${data.resourceCourseId}');
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
                            addOption(data, "resourceMajorIdd",'${data.resourceMajorId}');
                        })
                }
            });
        }
    });

    function changeMajor() {
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_SUBJECT_ID ='"+$("#resourceSubjectIdd").val()+"' and RESOURCE_MAJOR_ID = '"+$("#resourceMajorIdd").val()+"'",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "resourceCourseIdd",'${data.resourceCourseId}');
                })
    }
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
        var JPKId = $("#JPKId").val();
        var resourceCourseId = $("#resourceCourseIdd").val();
        var resourceMajorId = $("#resourceMajorIdd").val();
        var resourceSubjectId = $("#resourceSubjectIdd").val();
        var jpkTypeName = $("#JPKResourceTypeName").val();
        var remark = $("#remark").val();
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({title: "请填写科目名称！",type: "info"});
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({title: "请填写学段！",type: "info"});
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({title: "请填写年级！",type: "info"});
            return;
        }
        if (JPKResourceTypeName == "" || JPKResourceTypeName == undefined || JPKResourceTypeName == null) {
            swal({title: "请填写精品课类型！",type: "info"});
            return;
        }
        $.post("<%=request.getContextPath()%>/resourceLibrary/JPK/saveJPKResourceType", {
            id:JPKId,
            resourceCourseId:resourceCourseId,
            resourceMajorId:resourceMajorId,
            resourceSubjectId:resourceSubjectId,
            jpkTypeName:jpkTypeName,
            remark:remark
        }, function (msg) {
            swal({title: msg.msg,type: msg.result});
            $("#dialog").modal('hide');
            $('#tableJPKType').DataTable().ajax.reload();
        })
    }
</script>



