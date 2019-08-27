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
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                团队名称：
                            </div>
                            <div class="col-md-2">
                                <input id="tname" onkeyup="keyup_submit()"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <a type="button" class="btn btn-default btn-clean"
                           href="<%=request.getContextPath()%>/major/daochuData">导出
                        </a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="tableTeaching" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var tableTeaching;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch', '${tt.departmentsId}');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")

        tableTeaching = $("#tableTeaching").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/major/teachingTeamList?planName=${planName}&memberNum=${column}'
            },
            "destroy": true,
            "columns": [
                {"data": "ID", "visible": false},
                {"data": "PLANNAME", "title": "团队名称"},
                {"data": "MAJORNAME", "title": "所属专业"},
                {"data": "MAJORCODE", "title": "专业代码"},
                {"data": "LEVELNAME", "title": "级别"},
                {
                    "data": "APPROVALTIME",
                    "title": "获批时间",
                    "render": function (data,type, row) {
                        return  row.APPROVALTIME.replace("-","");

                    }
                },
                { "data": "CHARGEPERSON","title": "团队负责人"},
                <c:forEach var="num" begin="1" end="${column}">
                {
                    "data": "name${num-1}",
                    "title": "成员${num==1?"":num}"
                },
                </c:forEach>
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.ID + '","' + row.requestFlag + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.ID + '","' + row.PLANNAME + '")/>&ensp;&ensp;'
                    }
                }
            ],
            'order': [1, 'desc'],
             paging: true,
             "dom": 'rtlip',
            language: language
        });
    })

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/course/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSearch');
        });
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/major/editTeachingTeam");
        $("#dialog").modal("show");
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/major/editTeachingTeam?id=" + id);
        $("#dialog").modal("show");
    }

    function del(id, planName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "团队名称：" + planName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/major/delTeachingTeam", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#right").load("<%=request.getContextPath()%>/major/TeachingTeam");
            });
        });
    }

    function search() {
        var planName = $("#tname").val();
        $("#right").load("<%=request.getContextPath()%>/major/TeachingTeam?planName=" + planName);
    }

    function searchclear() {
        $("#tname").val("");
        search();
    }

    function getLeaderPage(id) {
        $("#dialog").load("<%=request.getContextPath()%>/teachingTeam/getLeaderPage?teamId=" + id);
        $("#dialog").modal("show");
    }
    function getMemberPage(id) {
        $("#dialog").load("<%=request.getContextPath()%>/teachingTeam/getMemberPage?teamId=" + id);
        $("#dialog").modal("show");
    }

    <!-- 文本搜索框回车查询 -->
    function keyup_submit(e) {
        var evt = window.event || e;
        if (evt.keyCode == 13) {
            search();
        }
    }
</script>