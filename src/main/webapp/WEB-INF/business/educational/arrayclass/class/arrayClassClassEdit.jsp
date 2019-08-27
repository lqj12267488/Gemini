<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/common/treeSelect.jsp" %>
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
            <span style="font-size: 14px;">${head}</span>
            <input id="arrayclassClassId" hidden value="${data.arrayclassClassId}"/>
            <input id="arrayclassId" hidden value="${data.arrayclassId}"/>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        班级名称
                    </div>
                    <div class="col-md-9">
                        <input id="className" value="${data.className}"/>
                        <div id="menuContent" class="menuContent">
                            <ul id="tree" class="ztree"></ul>
                        </div>
                        <input id="classId" hidden value="${data.classId}"/>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        系部名称
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" value="${data.departmentsId}"
                                onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业名称
                    </div>
                    <div class="col-md-9">
                        <select id="majorCode" value="${data.majorCode}"/>
                    </div>
                </div>--%>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教室名称
                    </div>
                    <div class="col-md-9">
                        <select id="roomId" value="${data.roomId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        班级学生数量
                    </div>
                    <div class="col-md-9">
                        <input id="studentNumber" value="${data.studentNumber}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="10" placeholder="最多输入10位数字"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        var selectTreeSetting = {
            view: {
                dblClickExpand: false,
                showIcon: false,
                showLine: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: onClick,
            }
        };
        initSelectTree("<%=request.getContextPath()%>/student/getMajorClassTree", "tree", "className", "classId", selectTreeSetting);
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${data.majorCode},${data.majorDirection},${data.trainingLevel}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id ",
            text: " class_room_name ",
            tableName: " T_JW_CLASSROOM ",
            where: " WHERE 1 = 1 and room_type='1' " ,
            orderby: " order by create_time desc"
        }, function (data) {
            addOption(data, 'roomId', '${data.roomId}');
        })
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCode');
        });
    }

    function onClick(e, treeId, treeNode) {
        if (treeNode.level == 3) {
            $("#className").attr("value", treeNode.name);
            $("#classId").attr("value", treeNode.id);
            hideMenu();
        }
    }

    function save() {
        var arrayclassClassId = $("#arrayclassClassId").val();
        var arrayclassId = $("#arrayclassId").val();
        var classId = $("#classId").val();
        var roomId = $("#roomId").val();
        var studentNumber = $("#studentNumber").val();
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        /*if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            alert("请选择系部！");
            return;
        }
        if (majorCode == "" || majorCode == undefined || majorCode == null) {
            alert("请选择专业！");
            return;
        }*/
        if (roomId == "" || roomId == undefined || roomId == null) {
            swal({
                title: "请填写教室名称！",
                type: "info"
            });
            return;
        }
        if (studentNumber == "" || studentNumber == undefined || studentNumber == null) {
            swal({
                title: "请填写班级学生数量！",
                type: "info"
            });
            return;
        }
        if (isNaN(studentNumber)) {
            swal({
                title: "班级学生数量只能为数字！",
                type: "info"
            });
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayclass/saveArrayClassClass", {
            arrayclassClassId: arrayclassClassId,
            arrayclassId: arrayclassId,
            classId: classId,
            roomId: roomId,
            studentNumber: studentNumber,
        }, function (msg) {
            hideSaveLoading();

            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



