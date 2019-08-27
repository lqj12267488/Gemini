<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="examTopicid" hidden value="${examTopic.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        考试名称
                    </div>
                    <div class="col-md-9">
                        <input id="f_exam" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${examTopic.examShow}" />
                        <input id="eid" type="hidden" value="${examTopic.examId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="f_department" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="f_major" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        考试科目
                    </div>
                    <div class="col-md-9">
                        <select id="f_course" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="f_term" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/examTopic/getExamName", function (data) {
            $("#f_exam").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_exam").val(ui.item.label);
                    $("#f_exam").attr("keycode", ui.item.value);
                    $("#eid").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_term','${examTopic.semester}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_course','${examTopic.examCourse}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_department','${examTopic.departmentsId}');
        });
        $("#f_department").change(function () {
            if($("#f_department").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#f_department").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_major');
                });
            }
        })

        if("" != '${examTopic.majorCode}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_major','${examTopic.majorCode}');
                });
        }
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#eid").val() == "" || $("#eid").val() == "0" || $("#eid").val() == undefined) {
            swal({
                title: "请填写考试名称！",
                type: "info"
            });
            return;
        }
        if ($("#f_department").val() == "" || $("#f_department").val() == "0" || $("#f_department").val() == undefined) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#f_major").val() == "" || $("#f_major").val() == "0") {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if($("#f_course").val() == "" || $("#f_course").val() == "0" || $("#f_course").val() == undefined){
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        if($("#f_term").val() == "" || $("#f_term").val() == "0" || $("#f_term").val() == undefined){
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/examTopic/saveExamTopic", {
            id: $("#examTopicid").val(),
            semester: $("#f_term").val(),
            examCourse: $("#f_course").val(),
            examId: $("#eid").val(),
            departmentsId: $("#f_department").val(),
            majorCode: $("#f_major").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#examTopic').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

