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
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <h5>${planName}&nbsp;>&nbsp;${data.courseName} &nbsp;> &nbsp;学时管理</h5>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
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
    <input hidden id="courseName" value="${data.courseName}">
    <input hidden id="planName" value="${planName}">
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getPlanTerms?detailsId=${data.id}',
            },
            "destroy": true,
            "columns": [
                {"data": "courseId", "visible": false},
                {"data": "planId", "visible": false},
                {"data": "term", "visible": false},
                {"data": "detailsId", "visible": false},
                {"data": "schoolYear", "title": "学年"},
                {"data": "termShow", "title": "学期"},
                {"data": "weeksNumber", "title": "学周"},
                {"data": "weeksHours", "title": "每周学时"},
                {"data": "totleHours", "title": "总学时"},
                {"data": "personId", "title": "签课教师(位)"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-bookmark" title="签课" onclick=' +
                                             'setTeacher("'+row.courseId+'","'+row.planId+'","'+ row.id+ '","'
                                                        + row.detailsId + '","' + row.personId + '")/>&ensp;&ensp;' +
                            '<span class="icon-credit-card" title="查看签课人员" onclick=selectList("'+ row.id+ '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function setTeacher(courseId , planId ,id,detailsId,personId) {
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/setSign?courseId=" + courseId + "&planId="+planId +
            "&id="+id +"&personId="+personId +"&courseName="+$("#courseName").val()+
            "&detailsId="+detailsId+"&planName="+$("#planName").val() );

        /*
                if(signId == null || signId ==undefined || signId=="" || signId=="null"){
                    $("#dialog").load("/coursesign/setSignTeacher?courseId=" + courseId + "&planId="+planId +
                        "&id="+id +"&courseName="+$("#courseName").val()+
                        "&detailsId="+detailsId+"&planName="+$("#planName").val() );
                }else{
                    $("#dialog").load("/coursesign/getSignTeacher?signId=" + signId );
                }
        */
        $("#dialog").modal("show");
    }

    function selectList(id) {
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/getSignList?termId="+id);
        $("#dialog").modal("show");
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/coursesign/toPlanDetails?id=${data.planId}&planName=${planName}")
    }

</script>