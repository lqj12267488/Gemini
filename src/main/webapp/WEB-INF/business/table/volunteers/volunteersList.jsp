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
                                社团名称：
                            </div>
                            <div class="col-md-2">
                                <input id="communitynameSel">
                            </div>
                            <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                            <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>

                        </div>


                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    $(document).ready(function () {


        search();
    })

    function search() {
        var groupNameSel = $("#communitynameSel").val();
        if (groupNameSel != ""){
            groupNameSel = '%' + groupNameSel + '%';
        }
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/volunteers/getVolunteersList',
                "data": {
                    groupNameSel:groupNameSel
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "department", "title": "学校分管部门"},
                 {"data": "communitycode", "title": "社团代码"},
                 {"data": "communityname", "title": "社团名称"},
                 {"data": "founddate", "title": "成立日期"},
                 {"data": "sum", "title": "总数"},
                 {"data": "teachingstaffnumber", "title": "教工数"},
                 {"data": "studentnumber", "title": "学生数"},
                 {"data": "name", "title": "姓名"},
                 {"data": "job", "title": "单位职务"},
                 {"data": "activitycontent", "title": "主要活动内容"},
                 {"data": "personsum", "title": "总数(人次)"},
                 {"data": "certificatenumber", "title": "获得证书数"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/volunteers/toVolunteersAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/volunteers/toVolunteersEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/volunteers/delVolunteers?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>