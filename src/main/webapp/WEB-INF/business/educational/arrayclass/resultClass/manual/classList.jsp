<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="block">
        <div class="block block-drop-shadow">
            <div class="content block-fill-white">
                <header class="mui-bar mui-bar-nav">
                    <h5 class="mui-title">排课计划 ： ${arrayClassName}班级列表 </h5>
                    <input id="arrayclassId" value="${arrayClassId}" hidden>
                </header>
                <div class="form-row">
                    <div class="col-md-1 tar">
                        系部：
                    </div>
                    <div class="col-md-3">
                        <select id="departmentSel"/>
                    </div>
                    <div class="col-md-1 tar">
                        专业：
                    </div>
                    <div class="col-md-3">
                        <select id="majorCodeSel"/>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="search()">查询
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="searchclear()">清空
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="block block-drop-shadow content">
            <div class="form-row">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="back()">返回
                </button>
            </div>
            <div class="form-row block" style="overflow-y:auto;">
                <table id="classList" cellpadding="0" cellspacing="0"
                       width="100%" style="max-height: 50%;min-height: 10%;"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var classList;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentSel');
        });

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " distinct id ",
                text: " name ",
                tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL||','||MAJOR_DIRECTION as id ," +
                " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC')||' -- '||FUNC_GET_DICVALUE(MAJOR_DIRECTION, 'ZXZYFX')  as name " +
                "from T_XG_MAJOR   ) ",
                where: " ",
                orderby: " "
            },
            function (data1) {
                addOption(data1, "majorCodeSel" );
            })

        classList = $("#classList").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/arrayClassResultClass/getClassList?arrayclassId='+$("#arrayclassId").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "classId", "visible": false},
                {"width": "22%", "data": "className", "title": "班级"},
                {"width": "22%", "data": "departmentsId", "title": "系部"},
                {"width": "22%", "data": "majorCode", "title": "专业"},
                {"width": "22%", "data": "roomId", "title": "教室"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='viewFlag' class='icon-eye-open' title='查看班级课表'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='editFlag' class='icon-edit' title='编辑班级课表'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delArray' class='icon-trash' title='清空排课'></a>";
                    }
                }
            ],
            'order': [[2, 'desc'], [1, 'desc']],
            "dom": 'rtlip',
            language: language
        });
        classList.on('click', 'tr a', function () {
            var data = classList.row($(this).parent()).data();
            var arrayclassId = data.arrayclassId;
            var classId = data.classId;
            var studentNumber = data.studentNumber;
            var className = data.className;
            if (this.id == "viewFlag") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/viewClass" +
                                        "?arrayclassId=" + arrayclassId+"&classId="+classId+
                                        "&studentNumber="+studentNumber +"&className="+className +
                                        "&arrayClassName=${arrayClassName}");
            }
            if (this.id == "editFlag") {
                $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/manualClass" +
                                        "?arrayclassId=" + arrayclassId+"&classId="+classId+
                                        "&studentNumber="+studentNumber +"&className="+className +
                                        "&arrayClassName=${arrayClassName}");
            }
            if (this.id == "delArray") {
                swal({
                    title: "确定要删除此班级排课结果?",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/arrayClassResultClass/delresultClassList", {
                        arrayclassId: arrayClassId,
                        classId:classId
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: msg.result
                            });
                            $('#arrayClassGrid').DataTable().ajax.reload();
                        }
                    });
                })
            }
        });
    })

    $("#departmentSel").blur(function(){
        var departmentSel = $("#departmentSel option:selected").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " distinct id ",
                text: " name ",
                tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL||','||MAJOR_DIRECTION as id ," +
                " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC')||' -- '" +
                                             "||FUNC_GET_DICVALUE(MAJOR_DIRECTION, 'ZXZYFX')  as name " +
                "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+departmentSel+"'  ) ",
                where: " ",
                orderby: " "
            },
            function (data1) {
                addOption(data1, "majorCodeSel");
            })
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/arrayClassResultClass/arrayClassList");
    }

    function searchclear() {
        $("#departmentSel").val("");
        $("#departmentSel option:selected").val("");
        $("#majorCodeSel").val("");
        $("#majorCodeSel option:selected").val("");
        search();
    }

    function search() {
        var departmentSel = $("#departmentSel option:selected").val();
        var majorCodeSel = $("#majorCodeSel option:selected").val();
        classList.ajax.url("<%=request.getContextPath()%>/arrayClassResultClass/getClassList?arrayclassId="+$("#arrayclassId").val()+
            "&departmentsId="+departmentSel+"&majorCode="+majorCodeSel
        ).load();
    }
</script>