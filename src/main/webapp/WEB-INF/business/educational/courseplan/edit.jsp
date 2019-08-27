<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <input id="id" hidden value="${data.planId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  计划名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="coursePlanName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;
                                "maxlength="30" placeholder="最多输入30个字" value="${data.planName}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>  系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 创建年份
                    </div>
                    <div class="col-md-9">
                        <select id="year"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'year', '${data.year}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorId', '${data.majorCode},${data.trainingLevel},${data.majorDirection}');
            });
        } else {
            $("#majorId").append("<option value='' selected>请选择</option>")
        }
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorId');
        });
    }

    function save() {
        var id = $("#id").val();
        var planName = $("#coursePlanName").val();
        var year = $("#year").val();
        var departmentsId = $("#departmentsId").val();
        var majorId = $("#majorId").val();
        if (planName == "" || planName == undefined || planName == null) {
            swal({
                title: "请填写计划名称!",
                type: "info"
            });
            return;
        }
        if (year == "" || year == undefined || year == null) {
            swal({
                title: "请选择创建年份!",
                type: "info"
            });
            return;
        }
        if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请选择系部名称!",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请选择专业名称!",
                type: "info"
            });
            return;
        }
        var arr = majorId.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/courseplan/save", {
            planId: id,
            planName: planName,
            year: year,
            departmentsId: departmentsId,
            majorCode: arr[0],
            trainingLevel: arr[1],
            majorDirection: arr[2],
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: msg.result});
            if(msg.status == '0'){
                return;
            }else{
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>



