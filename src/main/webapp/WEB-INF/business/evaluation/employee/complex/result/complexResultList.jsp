<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
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
                                综合评教名称:
                            </div>
                            <div class="col-md-3">
                                <input id="complexTaskNameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期:
                            </div>
                            <div class="col-md-3">
                                <select id="termSel" type="text"/>
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
                    <table id="ComplexTaskTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var ComplexTaskTable;
    var eType = '0';
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel');
        });

        ComplexTaskTable = $("#ComplexTaskTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/evaluation/complex/getComplexTask?testFlag=1&evaluationType='+eType
            },
            "destroy": true,
            "columns": [
                {"data": "complexTaskId", "visible": false},
                {"data": "term", "visible": false},
                {"width": "25%", "data": "complexTaskName", "title": "综合评教名称"},
                {"width": "10%", "data": "score", "title": "总分"},
                {"width": "10%", "data": "termShow", "title": "学期"},
                {"width": "10%", "data": "creator", "title": "操作人"},
                {"width": "10%", "data": "startTime", "title": "操作时间"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (date,type,row) {
                        return  '<a class="icon-cog" title="查看评价结果" id="editTaskResult" />&nbsp;&nbsp;&nbsp;'
                                /*+'<a class="icon-download-alt" title="导出结果" ' +
                            ' href="/evaluation/complex/exportComplexResult?complexTaskId='+row.complexTaskId +
                            '&complexTaskName='+row.complexTaskName+'"/>'*/;
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });

        ComplexTaskTable.on('click', 'tr a', function () {
            var data = ComplexTaskTable.row($(this).parent()).data();
            if(this.id == "editTaskResult"){// 子评教管理
                $("#right").load( "<%=request.getContextPath()%>/evaluation/complex/getResult?" +
                    "complexTaskId="+data.complexTaskId+"&complexTaskName="+data.complexTaskName+
                    "&evaluationType="+eType);
            }else if(this.id == "insertResult"){// 生成评教结果
                $.get("<%=request.getContextPath()%>/evaluation/complex/insertResult?complexTaskId="+data.complexTaskId, function (msg) {
                    swal({title: msg.msg, type: "success"});
                    if (msg.status == 1) {
                        $('#ComplexTaskTable').DataTable().ajax.reload();
                    }
                })
            }
        });

    })

    function search() {
        var complexTaskNameSel = $("#complexTaskNameSel").val();
        var term = $("#termSel option:selected").val();
        ComplexTaskTable.ajax.url("<%=request.getContextPath()%>/evaluation/complex/getComplexTask?testFlag=1&"+
            "complexTaskName=" + complexTaskNameSel +"&term="+term +"&evaluationType="+eType
        ).load();
    }

    function searchclear() {
        $("#complexTaskNameSel").val("");
        $("#termSel option:selected").val("");
        $("#termSel").val("")
        search();
    }

</script>