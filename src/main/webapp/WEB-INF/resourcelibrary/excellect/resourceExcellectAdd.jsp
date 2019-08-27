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
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceName" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        资源类型
                    </div>
                    <div class="col-md-9">
                        <select id="resourceType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        上传资源
                    </div>
                    <div class="col-md-9">
                        <input type="file" name="file" id="resource"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        缩略图&nbsp;&nbsp;
                    </div>
                    <div class="col-md-9">
                        <input type="file" name="file" id="cover"
                               accept="image/jpg,image/jpeg,image/gif,image/png,image/bmp"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        学科
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectId" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="resourceMajorId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="resourceCourseId"  onchange="change()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        精品课类型
                    </div>
                    <div class="col-md-9">
                        <select id="jpkResourceTypeName" />
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
     <%--           <div class="col-md-3 tar">
                    是否设置为精品课
                </div>
                <div class="col-md-9">
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio"  class="validate[required]"
                                   name="startFlag"
                                   value="0" id="no" onchange="changejpk()"/> 否
                        </label>
                    </div>
                    <div class="checkbox-inline">
                        <label>
                            <input type="radio" class="validate[required]"
                                   name="startFlag" value="1" id="ok" onchange="changejpk()"/> 是
                        </label>
                    </div>

                </div>
                <div class="form-row" id="jpkdiv">
                    <div class="col-md-3 tar">
                        精品课类型
                    </div>
                    <div class="col-md-9">
                        <select id="jpkResourceTypeName" />
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"  />
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

<script>
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
            addOption(data, 'resourceType');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYGS", function (data) {
            addOption(data, 'resourceFormat');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=ZYK_BB", function (data) {
            addOption(data, 'edition');
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
    function changejpk() {
        var jpkvalue = $('input[name="startFlag"]:checked').val();
        if(jpkvalue=='0'){
            $('#jpkdiv').hide();
        }else{
            $('#jpkdiv').show();
        }
    }

    function change() {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " id ",
                text: " resource_jpktypename ",
                tableName: " ZYK_EXCELLECT_TYPE  ",
                where: " where resource_subject_id = '"+$("#resourceSubjectId").val()+"' and resource_major_id = '"+$("#resourceMajorId").val()+"' and resource_course_id = '"+$("#resourceCourseId").val()+"'",
                orderby: " "
            },
            function (data) {
                addOption(data, "jpkResourceTypeName");
            })
    }
    function save() {
        var resource = $("#resource").val();
        if(resource!=null||resource!=''){
            var resources = resource.split('.');
            var suffix = resources[1];
            if (".avi.wmv.mpeg.mov.mkv.f4v.m4v.rmvb.rm.3gp.dat.ts.mts.vob.".indexOf("." + suffix + ".") != -1) {
                swal({title: "请上传mp4或者flv格式！", type: "info"});
                return;
            }
        }

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
        var aedition = $("#edition").val();
        var remark = $("#remark").val();
        var jpkTypeName = $("#jpkResourceTypeName").val();
        if(jpkTypeName =="" || jpkTypeName ==null || jpkTypeName==undefined){
            swal({
                title: "请填写精品课类型名称！",
                type: "info"
            });
            return;
        }
        if (resourceName == "" || resourceName == undefined || resourceName == null) {
            swal({
                title: "请填写资源名称！",
                type: "info"
            });
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({
                title: "请选择学段！",
                type: "info"
            });
            return;
        }
        if (resourceMajorId == "" || resourceMajorId == undefined || resourceMajorId == null) {
            swal({
                title: "请选择年级！",
                type: "info"
            });
            return;
        }
        if (resourceCourseId == "" || resourceCourseId == undefined || resourceCourseId == null) {
            swal({
                title: "请选择科目！",
                type: "info"
            });
            return;
        }

        if (resourceFormat == "" || resourceFormat == undefined || resourceFormat == null) {
            swal({
                title: "请选择资源格式！",
                type: "info"
            });
            return;
        }

        var formData = new FormData();
        var resource = document.getElementById("resource");
        formData.append("file", resource.files[0]);
        var resourceVal = $("#resource").val();
        var resource_end =resourceVal.split(".");

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

        $.ajax({
            url:'<%=request.getContextPath()%>/resourceLibrary/excellect/saveExcellect' +
            '?resourceName='+resourceName+
            '&resourceType='+resourceType +'&resourceSubjectId='+resourceSubjectId +'&resourceMajorId='+resourceMajorId+
            '&resourceCourseId='+resourceCourseId +'&resourceFormat='+resourceFormat +'&remark='+remark+'&coverRemark='+coverRemark+'&jpkTypeName='+jpkTypeName,
            type:"post",
            processData:false,
            contentType:false,
            data:formData,
            success:function(msg){
               if (msg.status == 1) {
                    swal({
                        title: "您是否要将该资源上传到资源库?",
                        text: "资源名:"+resourceName,
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "否",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "是",
                        closeOnConfirm: false
                    }, function () {
                        $.ajax({
                            url:'<%=request.getContextPath()%>/resourcePublic/savePublic' +
                            '?resourceName='+resourceName+'&resourceId='+msg.result+
                            '&resourceType='+resourceType +'&resourceSubjectId='+resourceSubjectId +'&resourceMajorId='+resourceMajorId+
                            '&resourceCourseId='+resourceCourseId +'&resourceFormat='+resourceFormat +'&edition='+aedition+'&remark='+remark+'&coverRemark='+coverRemark,
                            type:"post",
                            processData:false,
                            contentType:false,
                            data:formData,
                            success:function(msg){
                                swal({
                                    title: msg.msg,
                                    type: "success"
                                });
                                $('#tableResource').DataTable().ajax.reload();
                            }
                            })
                })
                $("#dialog").modal('hide');
                $('#tableResource').DataTable().ajax.reload();
            }
          }}
        );

    }
</script>



