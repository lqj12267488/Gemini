<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
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
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="eName" class="js-example-basic-single"></input>
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
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExam()">新增考试信息
                        </button>
                        <br>
                    </div>
                    <table id="examTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#examTable").DataTable({
            "processing": true,
            "serverSide": true,
            paging: true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/exam/getExamList',
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "term", "visible": false},
                {"data": "examName", "title": "考试名称"},
                {"data": "termShow", "title": "学期"},
                {"data": "examTypes", "title": "类型"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var html = '<span class="icon-edit" title="修改" onclick=editExam("' + row.examId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delExam("' + row.examId + '","' + row.examName + '")/>&ensp;&ensp;' +
                            '<span class="icon-time" title="设置考试时间" onclick=examTimeList("' + row.examId + '","' + row.examName + '")/>&ensp;&ensp;' +
                            '<span class="icon-user" title="设置监考教师" onclick=setTeacher("' + row.examId + '")/>&ensp;&ensp;';
                        if (row.examTypes == '期末考试') {
                            //新增考试学期
                            html += '<span class="icon-book" title="设置考试班级" onclick=examClassList("' + row.examId + '","' + row.examName + '","'+row.term+'")/>'
                        }
                        return html;
                    }
                }
            ],
            'order': [[0, 'desc']],
            "dom": 'rtlip',
            "language": language
        });
    });

    function setTeacher(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toSetTeacher", {
            id: id,
        });
        $("#dialog").modal("show")
    }

    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toAdd");
        $("#dialog").modal("show")
    }

    function editExam(id, examName) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/toEdit?id=" + id);
        $("#dialog").modal("show")
    }

    function examTimeList(id, examName) {
        $("#right").load("<%=request.getContextPath()%>/exam/examTimeList", {
            id: id,
            name: examName
        });
    }

    function examClassList(id, examName,term) {
        $("#right").load("<%=request.getContextPath()%>/exam/examClassList", {
            id: id,
            name: examName,
            term:term
        });
    }

    function delExam(id, examName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "考试名称：" + examName + "\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#examTable').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#eName").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamList").load();
    }

    function search() {
        var eName = $("#eName").val();
        if (eName == "" && eName == "") {

        } else {
            table.ajax.url("<%=request.getContextPath()%>/exam/getExamList?examName=" + eName).load();
        }
    }


</script>