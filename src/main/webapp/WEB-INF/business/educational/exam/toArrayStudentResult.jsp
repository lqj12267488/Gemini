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
                    <table id="toAutoStudentTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                    <div  id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
                        <img src="<%=request.getContextPath()%>/../../../libs/img/app/loading.gif" style="height: 50px;text-align: center"/>
                        <h3>正在操作中，请稍后……</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#toAutoStudentTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/exam/getExamList',
            },
            "destroy": true,
            "columns": [
                {"data": "examId", "visible": false},
                {"data":"examName","title":"考试名称"},
                {"data":"termShow","title":"学期"},
                {"data":"startTime","title":"开始时间"},
                {"data":"endTime","title":"结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-keyboard" title="学生排考" onclick=autoStudentArray("' + row.examId + '")/>&ensp;&ensp;' +
                            '<span class="icon-zoom-out" title="查看排考结果" onclick=arrayStudentResult("' + row.examId + '","'+row.examName+'")/>&ensp;&ensp;';
                    }
                }

            ],
            "dom": 'rtlip',
            "language": language
        });


    })


         //学生排考
       function autoStudentArray(examId) {
            $.get("<%=request.getContextPath()%>/exam/auto/student/checkStudentArray?examId="+examId, function (data) {
                if(data.status==1){
                    swal({title: data.msg, type: "error"});
                } else{
                    $.post("<%=request.getContextPath()%>/exam/auto/student/autoStudentArray", {
                        examId: examId
                    }, function (msg) {
                        if(msg==1){
                            swal({title: msg.msg, type: "success"});
                            $('#toAutoStudentTable').DataTable().ajax.reload();
                        }else{
                            swal({title: msg.msg, type: "success"});
                            $('#toAutoStudentTable').DataTable().ajax.reload();
                        }

                    });

                  /*
                   $.get("/exam/auto/student/autoStudentArray?examId="+examId, function (data) {
                           //$("#layout").css('display','block');
                           swal({title: data.msg, type: "success"});
                           $('#toAutoStudentTable').DataTable().ajax.reload();
                           //$("#layout").css('display','none');

                  })*/
             }
           })
        }
    //查看学生排考结果
    function arrayStudentResult(examId,examName) {
        $("#right").load("<%=request.getContextPath()%>/exam/auto/student/arrayStudentResult?examId="+examId+"&examName="+examName);
    }


    function searchclear() {
        $("#eName").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamList").load();
    }

    function search() {
        var eName = $("#eName").val();
        if (eName == "" && eName == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/exam/getExamList?examName="+eName).load();
        }
    }


</script>