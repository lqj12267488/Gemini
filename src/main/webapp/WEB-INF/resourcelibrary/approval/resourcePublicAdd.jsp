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
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>

            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资源名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资源类型
                    </div>
                    <div class="col-md-9">
                        <select id="resourceType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>上传资源
                    </div>
                    <div class="col-md-9">
                        <input type="file" name="file" id="resource"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>缩略图&nbsp;&nbsp;
                    </div>
                    <div class="col-md-9">
                        <input type="file" name="file" id="cover"
                               accept="image/jpg,image/jpeg,image/gif,image/png,image/bmp"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseId"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源格式
                    </div>
                    <div class="col-md-9">
                        <select id="resourceFormat" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"
                               maxlength="150" placeholder="最多输入150个字" />
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

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data, 'resourceType');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            addOption(data, 'resourceFormat');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceSubjectId");
        })
    });

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

    $("#resourceMajorId").blur(function(){
        if( $("#resourceMajorId").val()!="" ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " RESOURCE_COURSE_ID ",
                    text: " RESOURCE_COURSE_NAME ",
                    tableName: " ZYK_TYPE_COURSE ",
                    where: " where RESOURCE_MAJOR_ID ='"+$("#resourceMajorId").val()+"' ",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, "resourceCourseId");
                })
        }
    });

    function save() {
        if ($("#resource").val() == "") {
            swal({title: "请选择文件！", type: "info"});
            return;
        }
        var resourceName = $("#resourceName").val();
        var resourceType = $("#resourceType").val();
        var resourceSubjectId = $("#resourceSubjectId").val();
        var resourceMajorId = $("#resourceMajorId").val();
        var resourceCourseId = $("#resourceCourseId").val();
        var resourceFormat = $("#resourceFormat").val();
        var remark = $("#remark").val();

        if (resourceName == "" || resourceName == undefined || resourceName == null) {
            swal({
                title: "请填写资源名称！",
                type: "info"
            });
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({
                title: "请选择学科！",
                type: "info"
            });
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }

        var formData = new FormData();
        var resource = document.getElementById("resource");
        formData.append("file", resource.files[0]);
        var resource = $("#resource").val();
        var resource_end =resource.split(".");

        if( resource_end[1]=='bat'|| resource_end[1]=="exe"){
            swal({title: "不可上传可执行文件！", type: "info"});
            return;
        }

        var coverRemark = "false";

        if(null == $("#cover").val()  || $("#cover").val() == "" ){
            formData.append("cover", resource.files[0]);
            coverRemark = "false";
        }else{
            var cover = document.getElementById("cover");
            formData.append("cover", cover.files[0]);
            coverRemark = "true";
        }
        showSaveLoading();
        $.ajax({
            url:'<%=request.getContextPath()%>/resourcePublic/addPublic' +
            '?resourceName='+resourceName+
            '&resourceType='+resourceType +'&resourceSubjectId='+resourceSubjectId +'&resourceMajorId='+resourceMajorId+
            '&resourceCourseId='+resourceCourseId +'&resourceFormat='+resourceFormat +'&remark='+remark+'&coverRemark='+coverRemark,
            type:"post",
            processData:false,
            contentType:false,
            data:formData,
            success:function(msg){
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#tableResource').DataTable().ajax.reload();
            }
        });

    }
</script>



