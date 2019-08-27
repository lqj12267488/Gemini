<%--
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2018/3/15
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="ttId" type="hidden" value="${toEdit.id}">
        </div>
        <div class="modal-body clearfix">

            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学年/学期
                    </div>
                    <div class="col-md-9">
                        <select id="addOrEdit_semester" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <div style="white-space:nowrap;">
                            <input id="deptSel" type="text" onclick="showMenu()" value="${toEdit.departmentName}"
                                   readonly/>
                        </div>
                        <div id="menuContent1" class="menuContent1">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                        <input id="deptId" type="hidden" value="${toEdit.department}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_teaId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.teacherName}"/>
                        <input id="addOrEdit_teacherId" type="hidden" value="${toEdit.teacherId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.courseName}"/>
                        <input id="addOrEdit_courseId" type="hidden" value="${toEdit.courseId}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 班级
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_cInfo" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.className}"/>
                        <input id="addOrEdit_classInfo" type="hidden" value="${toEdit.classInfo}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级人数
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_studentNum" type="number" class="validate[required,maxSize[50]] form-control" value="${toEdit.studentNum}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        周学时
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_weekTime" type="number" class="validate[required,maxSize[50]] form-control" value="${toEdit.weekTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        已聘职称
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_employedTitle" type="text" class="validate[required,maxSize[50]] form-control" value="${toEdit.employedTitle}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        非本系（部）部门
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_otherDept" type="text" class="validate[required,maxSize[50]] form-control" value="${toEdit.otherDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>填表人
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_pBy" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[50]] form-control" value="${toEdit.preparedByName}"/>
                        <input id="addOrEdit_preparedBy" type="hidden" value="${toEdit.preparedBy}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>填表时间
                    </div>
                    <div class="col-md-9">
                        <input id="addOrEdit_preparedTime" type="date" class="validate[required,maxSize[50]] form-control" value="${toEdit.preparedTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考核方式
                    </div>
                    <div class="col-md-9">
                        <select id="examMethod" name="examMethod" class="required" msg="请选择考核方式！"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="addOrEdit_remarks" class="form-control" style="resize: none;">${toEdit.remarks}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    function save() {
        var semester = $("#addOrEdit_semester").val();
        var department = $("#deptId").val();
        var teacherId = $("#addOrEdit_teacherId").val();
        var courseId = $("#addOrEdit_courseId").val();
        var classInfo = $("#addOrEdit_classInfo").val();
        var studentNum = $("#addOrEdit_studentNum").val();
        var employedTitle = $("#addOrEdit_employedTitle").val();
        var otherDept = $("#addOrEdit_otherDept").val();
        var preparedBy = $("#addOrEdit_preparedBy").val();
        var preparedTime = $("#addOrEdit_preparedTime").val();
        var weekTime = $("#addOrEdit_weekTime").val();
        var remarks = $("#addOrEdit_remarks").val();

        if (semester == "" || semester == null) {
            swal({
                title: "请选择学年/学期",
                type: "info"
            });
            return;
        }
        if (department == "" || department == null) {
            swal({
                title: "请选择系部",
                type: "info"
            });
            return;
        }
        if (teacherId == "" || teacherId == null) {
            swal({
                title: "请输入教师名称",
                type: "info"
            });
            return;
        }

        
        if ($("#addOrEdit_courseId").val() == "" || $("#addOrEdit_courseId").val() == null) {
            swal({
                title: "请填写课程",
                type: "info"
            });
            return;
        }
        if ($("#addOrEdit_classInfo").val() == "" || $("#addOrEdit_classInfo").val() == null) {
            swal({
                title: "请填写班级",
                type: "info"
            });
            return;
        }

        if (preparedBy == "" || preparedBy == null) {
            swal({
                title: "请输入填表人",
                type: "info"
            });
            return;
        }
        if (preparedTime == "" || preparedTime == null) {
            swal({
                title: "请输入填表时间",
                type: "info"
            });
            return;
        }
        var examMethod = $("#examMethod").val();
        if (examMethod == "" || examMethod == null) {
            swal({
                title: "请选择考核方式",
                type: "info"
            });
            return;
        }


        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teachingTask/saveTeachingTask", {
            id: $("#ttId").val(),
            semester: semester,
            department: department,
            teacherId: teacherId,
            courseId: courseId,
            classInfo: classInfo,
            studentNum: studentNum,
            weekTime: weekTime,
            employedTitle: employedTitle,
            otherDept: otherDept,
            preparedBy: preparedBy,
            preparedTime: preparedTime,
            remarks: remarks,
            examMethod: examMethod
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#bMGrid').DataTable().ajax.reload();
            } else {
                swal({
                    title: msg.msg,
                    type: "error"
                });
            }
        })
    }

    $(function () {
        if(""!=$("#ttId").val()){
            $.get("<%=request.getContextPath()%>/common/getClassBeanByDept",
                {deptId:'${toEdit.department}'}
                , function (data) {
                    $("#addOrEdit_cInfo").autocomplete({
                        source: data,
                        select: function (event, ui) {
                            $("#addOrEdit_cInfo").val(ui.item.label);
                            $("#addOrEdit_cInfo").attr("keycode", ui.item.value);
                            $("#addOrEdit_classInfo").val(ui.item.value);

                            $.get("<%=request.getContextPath()%>/student/getStudentNumByClassId",{
                                classId:ui.item.value
                            },function (data) {
                                $("#addOrEdit_studentNum").val(data);
                            })
                            return false;
                        }
                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>")
                            .append("<a>" + item.label + "</a>")
                            .appendTo(ul);
                    };
                })
        }

        autoComplateOptions('addOrEdit_cId', "<%=request.getContextPath()%>/common/getCouresByName",
            "addOrEdit_courseId");

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'addOrEdit_semester', '${toEdit.semester}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCKSKHFF", function (data) {
            addOption(data, 'examMethod', '${toEdit.examMethod}');
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#addOrEdit_teaId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_teaId").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_teaId").attr("keycode", ui.item.value);
                    $("#addOrEdit_teacherId").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

            $("#addOrEdit_pBy").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#addOrEdit_pBy").val(ui.item.label.split("  ----  ")[0]);
                    $("#addOrEdit_pBy").attr("keycode", ui.item.value);
                    $("#addOrEdit_preparedBy").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })


        /*$("#addOrEdit_cId").autocomplete({
            source: function (request , response) {
                $.get("<%=request.getContextPath()%>/common/getCouresByName",{
                  name: request.term
                },function(data){
                    if(data==''){
                        $("#addOrEdit_courseId").val('');
                    }
                    response( $.ui.autocomplete.filter(
                        data, request.term ));
                })
            },
            select: function (event, ui) {
                debugger;
                $("#addOrEdit_cId").val(ui.item.label.split("  ----  ")[0]);
                $("#addOrEdit_cId").attr("keycode", ui.item.value);
                $("#addOrEdit_courseId").val(ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            debugger;
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };*/

        <%--$.get("<%=request.getContextPath()%>/common/getClassBean", function (data) {--%>
            <%--$("#addOrEdit_cInfo").autocomplete({--%>
                <%--source: data,--%>
                <%--select: function (event, ui) {--%>
                    <%--$("#addOrEdit_cInfo").val(ui.item.label);--%>
                    <%--$("#addOrEdit_cInfo").attr("keycode", ui.item.value);--%>
                    <%--$("#addOrEdit_classInfo").val(ui.item.value);--%>
                    <%--return false;--%>
                <%--}--%>
            <%--}).data("ui-autocomplete")._renderItem = function (ul, item) {--%>
                <%--return $("<li>")--%>
                    <%--.append("<a>" + item.label + "</a>")--%>
                    <%--.appendTo(ul);--%>
            <%--};--%>
        <%--})--%>

        $.get("<%=request.getContextPath()%>/getDeptTeachTree", function (data) {
            var editRangezTree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var node;
            var lis = $("#deptId").val().split(",");
            //设置选择节点
            for (var i = 0; i < lis.length; i++) {
                if(lis[i]!=""){
                    node = editRangezTree.getNodeByParam("id", lis[i], null);
                    var callbackFlag = $("#" + lis[i]).attr("checked");
                    editRangezTree.checkNode(node, true, false, callbackFlag);
                }
            }
        });
    });

    var setting = {
        check: {
            enable: true,
            chkStyle: "radio",
            chkboxType: {"Y": "s", "N": "ps"}
        },
        view: {
            dblClickExpand: false,
            showIcon: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onCheck: onCheck
        }
    };

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = zTree.getCheckedNodes(true),
            v = "";
        for (var i = 0, l = nodes.length; i < l; i++) {
            v += nodes[i].name + ",";
        }
        if (v.length > 0) v = v.substring(0, v.length - 1);
        var deptId = $("#deptId");
        deptId.attr("value", v);
    }

    function showMenu() {
        var cityObj = $("#deptId");
        var cityOffset = $("#deptId").offset();
        $("#menuContent1").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight() + "px"
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent1").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "deptSel" || event.target.id == "menuContent1" || $(event.target).parents("#menuContent1").length > 0)) {
            hideMenu();
            var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = zTree.getCheckedNodes(true);
            $("#deptId").val(getChildNodes(nodes));//获取子节点
            $("#deptSel").val(getChildNodesSel(nodes));//获取子节点

            $.get("<%=request.getContextPath()%>/common/getClassBeanByDept",
                {deptId:getChildNodes(nodes)}
                , function (data) {
                $("#addOrEdit_cInfo").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#addOrEdit_cInfo").val(ui.item.label);
                        $("#addOrEdit_cInfo").attr("keycode", ui.item.value);
                        $("#addOrEdit_classInfo").val(ui.item.value);

                            $.get("<%=request.getContextPath()%>/student/getStudentNumByClassId",{
                                classId:ui.item.value
                            },function (data) {
                                $("#addOrEdit_studentNum").val(data);
                            })
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }
    }

    function getChildNodesSel(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (!treeNode[i].isParent)
                nodes += treeNode[i].name + ",";
        }
        return nodes.substring(0, nodes.length - 1);
    }

    function getChildNodes(treeNode) {
        var nodes = "";
        for (i = 0; i < treeNode.length; i++) {
            if (!treeNode[i].isParent) {
                nodes += treeNode[i].id + ",";
            }

        }
        return nodes.substring(0, nodes.length - 1);
    }
</script>
<style>
    #menuContent1 {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>


