<%--协同办公-通讯录
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2017/10/24
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12" id="roleList">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="block block-drop-shadow">
                            <div class="content block-fill-white">
                                <div class="form-row">
                                    <div class="col-md-10" style="overflow: hidden;  margin-bottom: 10px">
                                        <div class="col-md-2 tar">
                                            学年/学期：
                                        </div>
                                        <div class="col-md-2" style="width: 15%;">
                                            <select id="search_semester"class="validate[required,maxSize[100]] form-control"></select>
                                        </div>
                                        <div class="col-md-2 tar">
                                            教师姓名：
                                        </div>
                                        <div class="col-md-2" style="width: 15%;">
                                            <input id="search_teaId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                                   class="validate[required,maxSize[50]] form-control autoInput" placeholder="请输入教师名称，并点选"/>
                                            <input id="search_teacherId" class="form-control" type="hidden">
                                        </div>
                                        <div class="col-md-2 tar">
                                            课程名称：
                                        </div>
                                        <div class="col-md-2" style="width: 15%;">
                                            <input id="search_cId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                                   class="validate[required,maxSize[50]] form-control autoInput" placeholder="请输入课程名称，并点选"/>
                                            <input id="search_courseId" class="form-control" type="hidden">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-default btn-clean" onclick="search()">
                                            查询
                                        </button>
                                        <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                            清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row">
                                    <button type="button" class="btn btn-default btn-clean" onclick="toAdd();">新增
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean" onclick="toImportExcel();">导入
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean" onclick="toOutData();">导出
                                    </button>
                                    <button type="button" class="btn btn-default btn-clean" onclick="outTemplate();">模板下载
                                    </button>
                                </div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="bMGrid" cellpadding="0" cellspacing="0" width="100%"
                                           style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var bMTable;

    var render ="<a id='toEdit' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
        "<a id='toDel' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;";

    $(document).ready(function () {
        search();
        bMTable.on('click', 'tr a', function () {
            var data = bMTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "toEdit") {
                $("#dialog").load("<%=request.getContextPath()%>/teachingTask/toEdit?id=" + id);
                $("#dialog").modal("show");
            }else if (this.id == "toDel") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "教学任务删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/teachingTask/deleteTeachingTask?ids=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#bMGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'search_semester', '');
        });

        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#search_teaId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#search_teaId").val(ui.item.label.split("  ----  ")[0]);
                    $("#search_teaId").attr("keycode", ui.item.value);
                    $("#search_teacherId").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

            $("#search_pBy").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#search_pBy").val(ui.item.label.split("  ----  ")[0]);
                    $("#search_pBy").attr("keycode", ui.item.value);
                    $("#search_preparedBy").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });

        $.get("<%=request.getContextPath()%>/common/getCoures", function (data) {
            $("#search_cId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#search_cId").val(ui.item.label.split("  ----  ")[0]);
                    $("#search_cId").attr("keycode", ui.item.value);
                    $("#search_courseId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });

        $.get("<%=request.getContextPath()%>/common/getDept", function (data) {
            $("#search_dId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#search_dId").val(ui.item.label.split("  ----  ")[0]);
                    $("#search_dId").attr("keycode", ui.item.value);
                    $("#search_deptId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        });

        $(".autoInput").keyup(function(){
            if($(this).val()==""||$(this).val()==null){
                $(this).attr("keycode","");
                $(this).next("input[type=hidden]").val("");
            } else {
                $(this).attr("keycode","NaN");
                $(this).next("input[type=hidden]").val("NaN");
            }
        });

    });

    function searchclear() {
        $(".form-control").val("");
        search();
    }
    function search() {
        var semester = $("#search_semester").val();
        var courseId = $("#search_courseId").val();
        var teacherId = $("#search_teacherId").val();

        bMTable = $("#bMGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teachingTask/getTeachingTaskList2',
                "data": {
                    semester : semester,
                    courseId : courseId,
                    teacherId : teacherId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "6%","data": "semesterName", "title": "学期"},
                {"width": "6%","data": "departmentName", "title": "系部"},
                {"width": "6%","data": "teacherName", "title": "教师姓名"},
                {"width": "6%","data": "courseName", "title": "课程名称"},
                {"width": "6%","data": "className", "title": "班级"},
                {"width": "6%","data": "studentNum", "title": "班级人数"},
                {"width": "6%","data": "weekTime", "title": "周学时"},
                {"width": "6%","data": "preparedByName", "title": "填表人"},
                {"width": "6%","data": "preparedTime", "title": "填表时间"},
                {"width": "6%","data": "examMethod", "title": "考核方式"},
                {"width": "11%","title": "操作", "render": function () {return render;}}
            ],
            'order' : [1,'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

    function toAdd(){
        $("#dialog").load("<%=request.getContextPath()%>/teachingTask/toAdd");
        $("#dialog").modal("show");
    }

    function outTemplate(){
        $("#dialog").load("<%=request.getContextPath()%>/teachingTask/toOutExcel");
        $("#dialog").modal("show");
    }

    function toOutData(){
        $("#dialog").load("<%=request.getContextPath()%>/teachingTask/toOutData");
        $("#dialog").modal("show");
    }

    function toImportExcel(){
        $("#dialog").load("<%=request.getContextPath()%>/teachingTask/toImportExcel");
        $("#dialog").modal("show");
    }

</script>