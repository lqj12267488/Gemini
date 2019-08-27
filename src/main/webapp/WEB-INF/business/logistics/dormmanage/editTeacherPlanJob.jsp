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
            <input id="teacherOrderId" name="teacherOrderId" hidden value="${teacherPlanJob.teacherOrderId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="edit_teacherId"
                               value="${teacherPlanJob.teacherName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30"
                               placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 联系方式
                    </div>
                    <div class="col-md-9">
                        <input id="edit_tel"
                               value="${teacherPlanJob.tel}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="11"
                               placeholder="最多输入11位字"/>
                    </div>
                </div>
                <div id="deptPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 楼宇名称
                    </div>
                    <div class="col-md-9">
                        <select id="edit_buildingId"/>
                    </div>
                </div>
                <div id="majorPproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 接班时间
                    </div>
                    <div class="col-md-9">
                        <input id="edit_officeStartTime" value="${teacherPlanJob.officeStartTime}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div id="coursePproperty" class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 交班时间
                    </div>
                    <div class="col-md-9">
                        <input readonly id="edit_officeEndTime" value="${teacherPlanJob.officeEndTime}" type="datetime-local"
                               class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        值班记录
                    </div>
                    <div class="col-md-9">
                        <input id="remark" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${teacherPlanJob.remark}"/>
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
    var teacherOrderId = $("#teacherOrderId").val();
    if (teacherOrderId != '') {
        $("#edit_teacherId").attr('readonly', 'readonly');
    }
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " building_name ",
                tableName: "T_JW_BUILDING",
                where: " WHERE building_type ='6'",
                orderby: " order by create_time desc"
            },
            function (data) {
                addOption(data, "edit_buildingId", '${teacherPlanJob.buildingId}');
            });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#edit_teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#edit_teacherId").val(ui.item.label);
                    $("#edit_teacherId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

        })
    });

    function save() {
        var buildingId = $("#edit_buildingId").val();
        var officeStartTime = $("#edit_officeStartTime").val();
        var tel = $("#edit_tel").val();
        if (teacherOrderId == '') {
            if ($("#edit_teacherId").attr("keycode") == "" || $("#edit_teacherId").attr("keycode") == undefined || $("#edit_teacherId").attr("keycode") == null) {
                swal({
                    title: "请选择教师！",
                    type: "info"
                });
                return;
            }
        }
        var phoneNum = /^1\d{10}$/;
        var telNum = /^0\d{2,3}-[1-9]\d{6,7}$/ // /^0\d{2,3}-?\d{7,8}$/;
        if($("#edit_tel").val()=="" || $("#edit_tel").val()==undefined || $("#edit_tel").val() == null){
            swal({
                title: "请填写联系方式！",
                type: "info"
            });
            return;
        }
        if (phoneNum.test($("#edit_tel").val()) === false && telNum.test($("#edit_tel").val()) === false) {
            swal({
                title: "联系方式填写不正确",
                type: "info"
            });
            //alert("联系人电话不正确");
            return;
        }
        if (buildingId == "" || buildingId == undefined || buildingId == null) {
            swal({
                title: "请选择楼宇！",
                type: "info"
            });
            return;
        }
        if (officeStartTime == "" || officeStartTime == undefined || officeStartTime == null) {
            swal({
                title: "请选择接班时间！",
                type: "info"
            });
            return;
        }

        var headT;
        var headTList;
        if (teacherOrderId == '') {
            headT = $("#edit_teacherId").attr("keycode");
            headTList = headT.split(",");
        }
        var officeStartTime1= officeStartTime.replace('T',' ');

        showSaveLoading();
        if (teacherOrderId != '') {
            $.post("<%=request.getContextPath()%>/dormmanage/teacherPlanJob/save", {
                teacherOrderId: $("#teacherOrderId").val(),
                buildingId: $("#edit_buildingId").val(),
                officeStartTime: officeStartTime1,
                tel: tel,
                remark: $("#remark").val()
            }, function (msg) {
                hideSaveLoading();
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#examTable').DataTable().ajax.reload();
            })
        } else {
            $.post("<%=request.getContextPath()%>/dormmanage/teacherPlanJob/save", {
                teacherOrderId: $("#teacherOrderId").val(),
                teacherId: headTList[1],
                teacherDept: headTList[0],
                buildingId: $("#edit_buildingId").val(),
                officeStartTime: officeStartTime1,
                tel: tel,
                remark: $("#remark").val()
            }, function (msg) {
                hideSaveLoading();
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#examTable').DataTable().ajax.reload();
            })
        }

    }

    function addFiles() {
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId=${businessId}&businessType=&tableName=${tableName}");
        $("#dialogFile").modal("show");
    }
</script>


