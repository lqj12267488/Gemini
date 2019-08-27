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
                    <table id="toPersonalStudentTable" cellpadding="0" cellspacing="0" width="100%"
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
        table = $("#toPersonalStudentTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/exam/getPersonalExamList',
            },
            "destroy": true,
            "columns": [
                {"data": "examId", "visible": false},
                {"data":"examName","title":"考试名称"},
                {"data":"termShow","title":"学期"},
                {"data":"startTime","title":"开始时间"},
                {"data":"endTime","title":"结束时间"},
                { "title": "操作",
                    "render": function (date,type,row) {
                        return '<a class="icon-eye-open" title="查看考试安排" id="searchPersonalResult"/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            if(this.id == "searchPersonalResult"){
                $("#right").load( "<%=request.getContextPath()%>/exam/personal/student/result?examId="+data.examId+"&examName="+data.examName);
            }
        });
    })
    function searchclear() {
        $("#eName").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamList?flag=1").load();
    }

    function search() {
        var eName = $("#eName").val();
        if (eName == "" && eName == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/exam/getExamList?examName="+eName).load();
        }
    }
</script>