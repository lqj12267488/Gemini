<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/25
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" class="validate[required,maxSize[100]] form-control"></select>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorShow" class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>班级名称
                    </div>
                    <div class="col-md-4">
                        <select id="classId" class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <select id="studentId" class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        性别
                    </div>
                    <div class="col-md-4">
                        <input id="sex" type="text" value="${studentPunish.sexShow}" key="${studentPunish.sex}"
                               class="validate[required,maxSize[100]] form-control" readonly/>
                    </div>
                    <div class="col-md-2 tar">
                        身份证号
                    </div>
                    <div class="col-md-4">
                        <input id="idcard" type="text" value="${studentPunish.idcard}"
                               class="validate[required,maxSize[100]] form-control" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处名称
                    </div>
                    <div class="col-md-4">
                        <input id="punishName" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${studentPunish.punishName}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处文号
                    </div>
                    <div class="col-md-4">
                        <input type="text" id="punishDocumentNumber"
                               class="validate[required,maxSize[100]] form-control"
                               value="${studentPunish.punishDocumentNumber}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>惩处级别
                    </div>
                    <div class="col-md-4">
                        <select id="punishLevel" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处时间
                    </div>
                    <div class="col-md-4">
                        <input id="punishTime" type="date" value="${studentPunish.punishTime}" class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>惩处内容
                    </div>
                    <div class="col-md-10">
                        <textarea id="punishContent" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${studentPunish.punishContent}">${studentPunish.punishContent}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处原因
                    </div>
                    <div class="col-md-10">
                        <textarea id="punishReason" type="text"
                                  class="validate[required,maxSize[100]] form-control"
                                  value="${studentPunish.punishReason}">${studentPunish.punishReason}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>惩处学期
                    </div>
                    <div class="col-md-4">
                        <select type="text" id="punishTerm" class="validate[required,maxSize[100]] form-control" />
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 惩处状态
                    </div>
                    <div class="col-md-4">
                        <select id="punishStatus"
                                class="validate[required,maxSize[20]] form-control"
                                value="${studentPunish.punishStatus}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        撤销时间
                    </div>
                    <div class="col-md-4">
                        <input id="cancelTime"
                               class="validate[required,maxSize[100]] form-control"
                               type="date"
                               value="${studentPunish.cancelTime}" readonly="readonly"/>
                    </div>
                    <div class="col-md-2 tar">
                       撤销文号
                    </div>
                    <div class="col-md-4">
                        <input id="cancelDocumentNumber"  value="${studentPunish.cancelDocumentNumber} " class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>惩处周期
                    </div>
                    <div class="col-md-4">
                        <select id="f_punishingCycle" class="validate[required,maxSize[20]] form-control"
                                value="${studentPunish.punishingCycle}"></select>
                    </div>
                    <div class="col-md-2 tar">
                        撤销原因
                    </div>
                    <div class="col-md-4">
                        <input id="cancelReason" class="validate[required,maxSize[100]] form-control" value="${studentPunish.cancelReason}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <textarea id="remark"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${studentPunish.remark}">${studentPunish.remark}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="id" value="${studentPunish.id}" type="hidden" >
    <input id="dept" value="${studentPunish.departmentsId}" type="hidden" >
    <input id="major" value="${studentPunish.majorShow}" type="hidden" >
    <input id="class" value="${studentPunish.classId}" type="hidden" >
    <input id="student" value="${studentPunish.studentId}" type="hidden" >
    <input id="flag" value="${flag}" type="hidden">
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function (){
//系统字典项
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSCCJB", function (data) {
            addOption(data, 'punishLevel', '${studentPunish.punishLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'punishTerm','${studentPunish.punishTerm}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSCCZT", function (data) {
            addOption(data, 'punishStatus', '${studentPunish.punishStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CCZQ", function (data) {
            addOption(data, 'f_punishingCycle', '${studentPunish.punishingCycle}');
        });
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId','${studentPunish.departmentsId}');
        });
        $("#f_punishingCycle").change(function () {
            $.get("<%=request.getContextPath()%>/studentRewardPunish/getStudentCancelTime?punishingCycle="+$("#f_punishingCycle").val()+"&punishTime="+$("#punishTime").val(),
                function (map) {
                    $("#cancelTime").val(map.cancelTime);
                }
            )

        });
        $("#punishTime").change(function () {
            if($("#f_punishingCycle").val() == ""|| $("#f_punishingCycle").val() == null){

            }else{
                $.get("<%=request.getContextPath()%>/studentRewardPunish/getStudentCancelTime?punishingCycle="+$("#f_punishingCycle").val()+"&punishTime="+$("#punishTime").val(),
                    function (map) {
                        $("#cancelTime").val(map.cancelTime);
                    }
                )
            }
        });

//通过系部id获取专业-方向-层次下拉列表
        $("#departmentsId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#departmentsId").val(),function (data) {
                addOption(data, "majorShow");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getMajorShowByDeptId?deptId="+$("#dept").val(),function (data) {
            addOption(data, "majorShow",'${studentPunish.majorShow}');
        })
//通过专业-方向-层次id获取班级下拉列表
        $("#majorShow").change(function(){
            $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#majorShow").val(), function (data) {
                addOption(data, "classId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getClassByMajorShow?majorShow="+$("#major").val(), function (data) {
            addOption(data, "classId", '${studentPunish.classId}');
        })
//通过班级id获取学生下拉列表
        $("#classId").change(function(){
            $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#classId").val(), function (data) {
                addOption(data, "studentId");
            })
        });
        $.get("<%=request.getContextPath()%>/common/getStudentByClassId?classId="+$("#class").val(), function (data) {
            addOption(data, "studentId",'${studentPunish.studentId}');
        })
//通过学生获取性别和身份证号
        $("#studentId").change(function(){
            $.get("<%=request.getContextPath()%>/studentRewardPunish/getStudentSexIdcard?studentId="+$("#studentId").val(),
                function (map) {
                    $("#sex").val(map.sexShow);
                    $("#sex").attr("key",map.sex);
                    $("#idcard").val(map.idcard);
                }
            )
        });
//查看详情设置控件只读
        if($("#flag").val()=="1"){
            $("#saveBtn").hide();
            $("input").attr('readonly','readonly');
            $("select").attr('disabled','disabled');
            $("textarea").attr('readOnly','readOnly');
        }
    })
    function closeView(){
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
        $("textarea").removeAttr('readOnly');
    }
    function save() {
        if ($("#departmentsId").val() == "") {
             swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#majorShow").val() == "") {
              swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if ($("#classId").val() == "") {
             swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if ($("#studentId").val() == "") {
           swal({
                title: "请选择学生姓名！",
                type: "info"
            });
            return;
        }
        if($("#punishName").val()=="" ||   $("#punishName").val() == undefined){
            swal({
                title: "请填写惩处名称！",
                type: "info"
            });
            return;
        }
        if($("#punishDocumentNumber").val()=="" || $("#punishDocumentNumber").val() == undefined){
             swal({
                title: "请填写惩处文号！",
                type: "info"
            });
            return;
        }
        if($("#punishLevel option:selected").val()=="" || $("#punishLevel option:selected").val() == undefined){
             swal({
                title: "请选择惩处级别！",
                type: "info"
            });
            return;
        }
        if($("#punishTime").val()=="" ||   $("#punishTime").val() == undefined){
            swal({
                title: "请填写惩处时间！",
                type: "info"
            });
            return;
        }
        if($("#punishContent").val()=="" ||   $("#punishContent").val() == undefined){
           swal({
                title: "请填写惩处内容！",
                type: "info"
            });
            return;
        }
        if($("#punishReason").val()=="" ||  $("#punishReason").val() == undefined){
           swal({
                title: "请填写惩处原因！",
                type: "info"
            });
            return;
        }
        if($("#punishTerm option:selected").val()=="" ||   $("#punishTerm option:selected").val() == undefined){
             swal({
                title: "请填写惩处学期！",
                type: "info"
            });
            return;
        }
        if($("#punishStatus option:selected").val()=="" || $("#punishStatus option:selected").val() == undefined){
            swal({
                title: "请选择惩处状态！",
                type: "info"
            });
            return;
        }
        if($("#f_punishingCycle option:selected").val()=="" || $("#f_punishingCycle option:selected").val() == undefined){
            swal({
                title: "请选择惩处周期！",
                type: "info"
            });
            return;
        }
        if(new Date($("#punishTime").val()).getTime()>new Date($("#cancelTime").val()).getTime()){
            swal({
                title: "惩处时间要早于撤销时间！",
                type: "info"
            });
            return;
        }
        var majorShow =$("#majorShow").val();
        var majorList = majorShow.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/studentRewardPunish/studentPunish/save", {
            id:$("#id").val(),
            studentId:$("#studentId").val(),
            departmentsId: $("#departmentsId").val(),
            majorCode: majorList[0],
            majorDirection:majorList[1],
            trainingLevel: majorList[2],
            classId: $("#classId").val(),
            sex:$("#sex").attr("key"),
            idcard:$("#idcard").val(),
            punishName: $("#punishName").val(),
            punishTime: $("#punishTime").val(),
            punishLevel: $("#punishLevel option:selected").val(),
            punishReason: $("#punishReason").val(),
            punishContent: $("#punishContent").val(),
            punishDocumentNumber:$("#punishDocumentNumber").val(),
            punishTerm:$("#punishTerm").val(),
            cancelTime:$("#cancelTime").val(),
            cancelReason:$("#cancelReason").val(),
            cancelDocumentNumber:$("#cancelDocumentNumber").val(),
            punishStatus:$("#punishStatus option:selected").val(),
            punishingCycle:$("#f_punishingCycle option:selected").val(),
            remark:$("#remark").val(),
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#studentPunishGrid').DataTable().ajax.reload();
        })
    }
</script>
