<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
        .iconBtx{
            color: #E9003A;
            font-size: 16px;
        }

    </style>
</head>
<div class="modal-dialog">
    <div class="tanchu-content">
        <div class="tanchu-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDialog()">
                &times;
            </button>
            <span style="margin-left:30px">${head}</span>
        </div>
        <div class="tanchu">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>资源名称
                </div>
                <div class="tc_l_r">
                    <input id="resourceName" />
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>上传资源
                </div>
                <div class="tc_l_r">
                    <input type="file" name="file" id="resource" style="width:240px" />
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    缩略图&nbsp;&nbsp;
                </div>
                <div class="tc_l_r">
                    <input type="file" name="file" id="cover" style="width:240px"
                           accept="image/jpg,image/jpeg,image/gif,image/png,image/bmp"/>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    <span class="iconBtx">*</span>资源类型
                </div>
                <div class="tc_l_r">
                    <select id="resourceType" value="${resourcePrivate.resourceType}"></select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    自定义分类
                </div>
                <div class="tc_l_r">
                    <select id="resourceCustom" value="${resourcePrivate.resourceCustom}"></select>
                </div>
            </div>
            <div class="tc_list">
                <div class="tc_l_l">
                    备注
                </div>
                <div class="tc_l_r">
                    <textarea id="remark"
                              class="validate[required,maxSize[20]] form-control"
                              value="${resourcePrivate.remark}">${resourcePrivate.remark}</textarea>
                </div>
            </div>
        </div>
        <div class="tc_an">
            <button type="button" id="saveBtn" class="tc_btn1" onclick="save()">保存
            </button>
            <button type="button" class="tc_btn2" onclick="closeDialog()">关闭
            </button>
        </div>
    </div>
</div>
<input id="personId" type="hidden" value="${personId}">
    <script>
        $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

        $(document).ready(function () {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZYK_ZYLX", function (data) {
                addOption(data,'resourceType','${resourcePrivate.resourceType}');
            });

            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: "type_id",
                    text: "type_name ",
                    tableName: "zyk_type_custom",
                    where: " where CREATOR = '"+$("#personId").val()+"'",
                    orderby: "  "
                },
                function (data) {
                    addOption(data, 'resourceCustom','${resourcePrivate.resourceCustom}');
                });
        });


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
            var resourceCustom = $("#resourceCustom option:selected").val();
            var resourceType = $("#resourceType option:selected").val();
            var remark = $("#remark").val();
            if (resourceName == "" || resourceName == undefined || resourceName == null) {
                swal({title: "请填写资源名称！", type: "info"});
                return;
            }
            if (resourceType == "" || resourceType == undefined || resourceType == null) {
                swal({title: "请填写资源类型！", type: "info"});
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
            showSaveLoading();

//            var resourceFile = new FormData(document.getElementById("rFile"));
            $.ajax({
                url:'<%=request.getContextPath()%>/resourcePrivate/insertResourcePrivate' +
                    '?resourceName='+resourceName+'&resourceCustom='+resourceCustom+
                    '&resourceType='+resourceType +'&remark='+remark +'&coverRemark='+coverRemark,
                type:"post",
                processData:false,
                contentType:false,
                data:formData,
                success:function(msg){
                    hideSaveLoading();

                    swal({title: msg.msg, type: msg.result});
                    if(msg.status == 1){
                        closeDialog();
                        $('#tablePrivate').DataTable().ajax.reload();
                    }
                }
            });
        }
    </script>