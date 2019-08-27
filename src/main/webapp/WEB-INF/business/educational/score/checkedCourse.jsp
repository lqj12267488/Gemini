<%--
  Created by IntelliJ IDEA.
  User: ZhangHao
  Date: 2018/3/15
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">选择班级</span>
        </div>
        <div class="modal-body clearfix">

            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学期
                    </div>
                    <div class="col-md-9">
                        <select id="checked_term" class="form-control" onchange="checkCourse()"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>课程
                    </div>
                    <div class="col-md-9">
                        <select id="checked_course" class="form-control">
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="exportScore1()">下载模板</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>

    $(function(){

        $.get("<%=request.getContextPath()%>/scoreMakeup/getTeachingTaskSemester", function (data) {

            if(data != null){

                addOption(data, 'checked_term');

            } else {

                $("#checked_term").html("<option value=''>无学期数据</option>")
            }

        });
    });

    function checkCourse(){

        var term = $("#checked_term").val();

        if(term != null && term != ""){

            $.post("<%=request.getContextPath()%>/scoreMakeup/checkCourseForTeacher",{
                semester:term,
                examId :'${scoreExamId}'
            },function(data){

                if(data != null && data != ""){

                    addOption(data, 'checked_course');

                } else {

                    $("#checked_course").html("<option value=''>无可导入课程</option>")
                }
            })
        }
    }

    function exportScore1() {

        var term = $("#checked_term").val();
        var course = $("#checked_course").val();

        if(term != null && term != "" && course != null && course != ""){

            window.location.href = "<%=request.getContextPath()%>/scoreMakeup/exportMakeupScore?type=${type}&scoreExamId=${scoreExamId}&term="+term+"&courseId="+course;

        } else {

            swal({
                title: "请选择要导入的学期和课程",
                type: "info"
            });
            return;
        }
    }
</script>


