<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 650px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" onclick="closedwindow()" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="pid" hidden value="${backboneTeacher.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教师姓名
                    </div>
                    <div class="col-md-9">
                        <input id="person" type="text" value="${backboneTeacher.teacherIdShow}"/>
                        <input id="perId" type="hidden" value="${backboneTeacher.teacherId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentSub" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorSub"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        性别
                    </div>
                    <div class="col-md-9">
                        <select id="f_sex"/>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>出生日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_birthday" type="date"
                               class="validate[required,maxSize[100]] form-control"
                               value="${backboneTeacher.birthday}"/>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>所学专业
                    </div>
                    <div class="col-md-9">
                        <input id="f_studyMajor" type="type"
                               class="validate[required,maxSize[100]] form-control"
                               value="${backboneTeacher.studyMajor}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    fillOtherMsg(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'f_sex','${backboneTeacher.sex}' );
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentSub', '${backboneTeacher.departmentId}');
        });


        if(""!='${backboneTeacher.majorCode}'){

            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " major_code",
                    text: " major_name ",
                    tableName: "t_xg_major",
                    where: " ",
                    orderby: " "
                },
                function (data1) {
                    addOption(data1, "majorSub", '${backboneTeacher.majorCode}');
                })
        }
        $("#departmentSub").change(function() {
            if($("#departmentSub").val()!=""){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                        id: " distinct id ",
                        text: " name ",
                        tableName: " (select  MAJOR_CODE as id ," +
                        " MAJOR_NAME as name " +
                        "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentSub").val()+"'  ) ",
                        where: " ",
                        orderby: " "
                    },
                    function (data1) {
                        addOption(data1, "majorSub", '${backboneTeacher.majorCode}');
                    })
            }
        });
    })

    function fillOtherMsg(id) {
        $.post("/majorLeader/getTeacherById", {
            tid: id
        }, function (res) {
            $("#f_sex").val(res.TEACHERSEX);
            $("#f_birthday").val(res.BIRTHDAY);
        });
    }

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }

    function saveDept() {
        var date = $("#f_birthday").val();
        date = date.replace('T', '');
        var departmentsId = $("#departmentSub").val();
        var major = $("#majorSub").val();
        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null) {
            swal({
                title: "请填写教师姓名",
                type: "info"
            });
            return;
        }
        if(departmentsId=="" || departmentsId == undefined || departmentsId == null){
            swal({
                title: "请填写系部！",
                type: "info"
            });
            return;
        }
        if(major=="" || major == undefined || major == null){
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        if($("#f_birthday").val()=="" || $("#f_birthday").val() == undefined || $("#f_birthday").val() == null){
            swal({
                title: "请填写出生日期！",
                type: "info"
            });
            return;
        }
        if($("#f_studyMajor").val()=="" || $("#f_studyMajor").val() == undefined || $("#f_studyMajor").val() == null){
            swal({
                title: "请填写所学专业！",
                type: "info"
            });
            return;
        }
        var pid=$("#pid").val();

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/backboneTeacher/updateBackboneTeacherById", {
            id: pid,
            teacherId: $("#perId").val(),
            departmentId:departmentsId,
            majorCode: major,
            sex: $("#f_sex").val(),
            birthday:date,
            studyMajor: $("#f_studyMajor").val(),

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#backboneTeacherGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



