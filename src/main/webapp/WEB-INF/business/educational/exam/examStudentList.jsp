<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 设置考生</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="did" onchange="changeSearchDept()"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid" onchange="changeSearchMajor()">
                                    <option value="">请选择系部</option>
                                </select>
                            </div>
                            <div class="col-md-1 tar">
                                考试科目：
                            </div>
                            <div class="col-md-2">
                                <select id="cid">
                                    <option value="">请选择专业</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="sname">
                            </div>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="edit()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="openSelectExam()">导入学生
                        </button>
                        <br>
                    </div>
                    <table id="grid" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="selectExam" tabindex="111" role="dialog" aria-labelledby="selectExam" aria-hidden="false"
     style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick='$("#selectExam").modal("hide")' aria-hidden="true">×
                </button>
                <h4 class="modal-title">选择考试</h4>
            </div>
            <div class="modal-body clearfix">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>考试名称
                    </div>
                    <div class="col-md-9">
                        <div>
                            <input id="cartypeShow" type="text" placeholder="请点击选择" onclick="showMenu()"/>
                        </div>
                        <div id="menuContent" class="menuContent">
                            <ul id="cartypeTree" class="ztree"></ul>
                        </div>
                        <input id="cartype" type="hidden"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default btn-clean" onclick="selectExam()">保存</button>
                <button class="btn btn-default btn-clean" onclick='$("#selectExam").modal("hide")'>关闭</button>
            </div>
        </div>
    </div>
</div>
<script>
    var table;

    function selectExam() {
        var examIds = $("#cartype").val();
        if (examIds == '' || examIds == undefined) {
            swal({
                title: "请选择考试",
                type: "info"
            });
            return;
        }
        $.get("<%=request.getContextPath()%>/eaxm/importStudent?examId=${examId}&examIds=" + examIds + "&examTypes=${examTypes}", function (data) {
            swal({
                title: data.msg,
                type: "info"
            }, function () {
                $("#selectExam").modal("hide");
                $('#grid').DataTable().ajax.reload();
            });
        });
    }

    function openSelectExam() {
        $.get("<%=request.getContextPath()%>/exam/getExamTree?examId=${examId}", function (data) {
            var cartypeTree = $.fn.zTree.init($("#cartypeTree"), setting, data);
            $("#selectExam").modal("show");
            $(".modal-backdrop").removeClass("modal-backdrop");
        });
    }


    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#cid").val("");
        $("#sname").val("");
        search()
    }

    function search() {
        var did = $("#did").val();
        var mid = $("#mid").val();
        var cid = $("#cid").val();
        table.ajax.url("<%=request.getContextPath()%>/exam/getStudentList?examId=${examId}&departmentsId="
            + did + "&majorCode=" + mid + "&classId=" + cid + "&studentName=" + $("#sname").val()).load();
    }

    function changeSearchDept() {
        var deptId = $("#did").val();
        $.post("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId", {
            deptId: deptId
        }, function (data) {
            addOption(data, 'mid');
        });
    }

    function changeSearchMajor() {
        var majorId = $("#mid").val();
        <%--$.post("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow", {--%>
            <%--majorShow: majorId.split(",")[0] + "," + majorId.split(",")[1],--%>
        <%--}, function (data) {--%>
            <%--addOption(data, 'cid');--%>
        <%--});--%>
        $.post("<%=request.getContextPath()%>/scoreCourse/getCourseByMajorShow2", {
            majorShow: majorId.split(",")[0] + "," + majorId.split(",")[1],
            termId:"${termId}"
        }, function (data) {
            addOption(data, 'cid');
        });
    }


    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'did');
        });
        table = $("#grid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/getStudentList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "departmentsId", "title": "系部"},
                {"data": "majorCode", "title": "专业"},
                {"data": "classId", "title": "班级"},
                {"data": "studentId", "title": "学生姓名"},
                {"data": "courseShow", "title": "考试科目"},
                {
                    "title": "考核方式",
                    "render": function (data, type, row) {
                        var s = "";
                        switch (row.examMethod) {
                            case '1':
                                s = "考试";
                                break;
                            case '2':
                                s = '考查';
                                break;
                        }
                        return s;
                    }
                },
                // {
                //     "title": "考试形式",
                //     "render": function (data, type, row) {
                //         var s = "";
                //         switch (row.examTypes) {
                //             case '1':
                //                 s = "普通";
                //                 break;
                //             case '3':
                //                 s = '机考';
                //                 break;
                //         }
                //         return s;
                //     }
                // },
                <c:if test="${examTypes == '毕业前补考' || examTypes == '毕业后补考'}">
                {"data": "termShow", "title": "补考学期"},
                </c:if>
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        //return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '","' + row.courseId + '")/>&ensp;&ensp;' +
                        return '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    });

    function edit(id, courseId) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toEditExamStudent", {
            id: id,
            examId: "${examId}",
            examTypes: "${examTypes}",
            courseId: courseId,
            termId:"${termId}"
        });
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/delExamStudent", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#grid').DataTable().ajax.reload();
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/makeup/makeupExamPlan");
    }
</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end
var setting = {
    check: {
        enable: true,
        chkboxType: {"Y": "", "N": ""}
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
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
        nodes = zTree.getCheckedNodes(true),
        v = "";
    for (var i = 0, l = nodes.length; i < l; i++) {
        v += nodes[i].name + ",";
    }
    if (v.length > 0) v = v.substring(0, v.length - 1);
    var deptId = $("#cartype");
    deptId.attr("value", v);
}

function showMenu() {
    var cityObj = $("#cartype");
    var cityOffset = $("#cartype").offset();
    $("#menuContent").css({
        left: cityOffset.left + "px",
        top: cityOffset.top + cityObj.outerHeight() + "px"
    }).slideDown("fast");
    $("body").bind("mousedown", onBodyDown);
}

function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "cartypeTreeShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
        hideMenu();
        var zTree = $.fn.zTree.getZTreeObj("cartypeTree"),
            nodes = zTree.getCheckedNodes(true);
        $("#cartype").val(getChildNodes(nodes));//获取子节点
        $("#cartypeShow").val(getChildNodesSel(nodes));//获取子节点
    }
}

function getChildNodesSel(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].name;
    }
    return "'" + nodes.join("','") + "'";
}

function getChildNodes(treeNode) {
    var nodes = new Array();
    for (i = 0; i < treeNode.length; i++) {
        nodes[i] = treeNode[i].id;
    }
    return nodes.join(",");
}
</script>
<style>
    #menuContent {
        display: none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>